import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:permission_handler/permission_handler.dart';

const String googleApiKey = 'your api key here'; // Replace with your real key

class MapRouteScreen extends StatefulWidget {
  const MapRouteScreen({super.key});

  @override
  State<MapRouteScreen> createState() => _MapRouteScreenState();
}

class _MapRouteScreenState extends State<MapRouteScreen> {
  late GoogleMapController mapController;
  LatLng? _currentLocation;
  final LatLng _destination = LatLng(23.0225, 72.5714); // Ahmedabad
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoords = [];

  Future<void> _checkPermissions() async {
    var status = await Permission.location.request();
    if (!status.isGranted) {
      openAppSettings();
    }
  }

  Future<void> _getCurrentLocation() async {
    await _checkPermissions();

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentLocation = LatLng(position.latitude, position.longitude);
    await _getPolylinePoints();

    setState(() {});
  }

  Future<void> _getPolylinePoints() async {
    if (_currentLocation == null) return;

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(_currentLocation!.latitude, _currentLocation!.longitude),
      destination: PointLatLng(_destination.latitude, _destination.longitude),
      mode: TravelMode.driving, // ✅ required field
    );


    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: request,
      googleApiKey: googleApiKey,
    );

    if (result.points.isNotEmpty) {
      _polylineCoords = result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();

      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.blue,
          width: 5,
          points: _polylineCoords,
        ),
      );

      // Animate map camera to fit the route
      Future.delayed(Duration(milliseconds: 500), () {
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            _boundsFromLatLngList([_currentLocation!, _destination]),
            60,
          ),
        );
      });

      setState(() {});
    } else {
      print('Error: ${result.errorMessage}');
    }
  }


  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double minLat = list.first.latitude, maxLat = list.first.latitude;
    double minLng = list.first.longitude, maxLng = list.first.longitude;

    for (LatLng latLng in list) {
      minLat = min(minLat, latLng.latitude);
      maxLat = max(maxLat, latLng.latitude);
      minLng = min(minLng, latLng.longitude);
      maxLng = max(maxLng, latLng.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map with Route')),
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation!,
          zoom: 14,
        ),
        onMapCreated: (controller) => mapController = controller,
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('start'),
            position: _currentLocation!,
            infoWindow: const InfoWindow(title: "Your Location"),
          ),
          Marker(
            markerId: const MarkerId('end'),
            position: _destination,
            infoWindow: const InfoWindow(title: "Destination"),
          ),
        },
        polylines: _polylines,
      ),
    );
  }
}

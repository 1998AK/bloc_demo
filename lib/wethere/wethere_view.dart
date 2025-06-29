import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

const String apiKey = '3f1607b368b62465f9f36844cb1cb05e'; // Your OpenWeatherMap API Key

class WeatherWithLocationScreen extends StatefulWidget {
  const WeatherWithLocationScreen({super.key});

  @override
  State<WeatherWithLocationScreen> createState() =>
      _WeatherWithLocationScreenState();
}

class _WeatherWithLocationScreenState
    extends State<WeatherWithLocationScreen> {
  String? city;
  String? description;
  double? temperatureC;
  double? latitude;
  double? longitude;
  String? error;
  bool loading = false;

  Future<void> _getLocationAndWeather() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("❌ Location services are disabled.");
      }

      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("❌ Location permission denied.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("❌ Location permission permanently denied.");
      }

      // Get current GPS position with best accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
        timeLimit: const Duration(seconds: 10),
      );

      latitude = position.latitude;
      longitude = position.longitude;

      print("📍 Actual lat: $latitude, lon: $longitude");

      // Fetch weather using Dio
      Dio dio = Dio();
      final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

      debugPrint("url is >> $url");
      final response = await dio.get(url);
      final data = response.data;

      setState(() {
        city = data['name'];
        description = data['weather'][0]['description'];
        temperatureC = data['main']['temp'];
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  Widget buildWeatherCard() {
    if (error != null) {
      return Text(
        "⚠️ $error",
        style: TextStyle(fontSize: 16, color: Colors.red),
        textAlign: TextAlign.center,
      );
    }

    if (loading) {
      return const CircularProgressIndicator();
    }

    if (temperatureC == null || city == null) {
      return const Text(
        "Tap the button below to get weather 🌤️",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      );
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          children: [
            const Icon(Icons.location_on, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 8),
            Text(
              city ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              description?.toUpperCase() ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Text(
              'Temperature: ${temperatureC?.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Lat: ${latitude?.toStringAsFixed(4)}, Lon: ${longitude?.toStringAsFixed(4)}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildWeatherCard(),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text("Get Current Weather"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: _getLocationAndWeather,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

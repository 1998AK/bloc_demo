import 'package:bloc_demo/bloc/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:bloc_demo/bloc/bottom_navigation_bar/bottom_navigation_bar_states.dart';
import 'package:bloc_demo/bloc/home/home_view.dart';
import 'package:bloc_demo/bloc/profile/profile_view.dart';
import 'package:bloc_demo/notification/local_notification.dart';
import 'package:bloc_demo/utils/app_color.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../googlemap/map_route_screen.dart';
import '../../locationget/location_ui.dart';
import '../../wethere/wethere_view.dart';
import 'bottom_navigation_bar_events.dart';

class BottomNavigationUi extends StatefulWidget {
  const BottomNavigationUi({super.key});

  @override
  State<BottomNavigationUi> createState() => _BottomNavigationUiState();
}

class _BottomNavigationUiState extends State<BottomNavigationUi> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationBarBloc(),
      child: Builder(
        builder: (context) => Scaffold(
          body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarStates>(
            builder: (context, state) {
              int currentIndex = 0;
              if (state is BottomNavigationIndexChange) {
                currentIndex = state.index;
              }

              return [
                const HomeView(),
                const LocationScreen(),
                const WeatherWithLocationScreen(),
                const NotificationScreen(),
                const MapRouteScreen(),

              ][currentIndex];
            },
          ),
          bottomNavigationBar: BottomBarBubble(
            backgroundColor: Colors.white,
            color: forgotPasswordColor,
            items: [
              BottomBarItem(iconData: Icons.home),
              BottomBarItem(iconData: Icons.location_on_outlined),
              BottomBarItem(iconData: Icons.sunny),
              BottomBarItem(iconData: Icons.notification_add_outlined),
              BottomBarItem(iconData: Icons.map_outlined),
            ],
            onSelect: (index) {
              context.read<BottomNavigationBarBloc>().add(
                OnTapBottom(getIndexFromUi: index),
              );
            },
          ),
        ),
      ),
    );
  }
}


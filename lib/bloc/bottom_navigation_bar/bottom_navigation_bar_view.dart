import 'package:bloc_demo/bloc/bottom_navigation_bar/bottom_navigation_bar_bloc.dart';
import 'package:bloc_demo/bloc/bottom_navigation_bar/bottom_navigation_bar_states.dart';
import 'package:bloc_demo/bloc/home/home_view.dart';
import 'package:bloc_demo/bloc/profile/profile_view.dart';
import 'package:bloc_demo/utils/app_color.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                const ProfileView(),
                Container(color: Colors.white),
                Container(color: Colors.white),
                Container(color: Colors.white),
              ][currentIndex];
            },
          ),
          bottomNavigationBar: BottomBarBubble(
            backgroundColor: appColor,
            color: yellowColor,
            items: [
              BottomBarItem(iconData: Icons.home),
              BottomBarItem(iconData: Icons.chat),
              BottomBarItem(iconData: Icons.add_box_outlined),
              BottomBarItem(iconData: Icons.ad_units_outlined),
              BottomBarItem(iconData: Icons.account_box_outlined),
            ],
            onSelect: (index) {
              // ✅ Now this context has access to BlocProvider
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


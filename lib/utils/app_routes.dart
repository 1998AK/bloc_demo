import 'package:bloc_demo/splash_view.dart';
import 'package:flutter/material.dart';

import '../bloc/bottom_navigation_bar/bottom_navigation_bar_view.dart';
import '../bloc/home/home_view.dart';
import '../bloc/login/login_view.dart';
import '../other/box_game.dart';

abstract class AppRoutes{

  static const splashScreen = '/splashScreen';
  static const homeView = '/homeView';
  static const loginView = '/loginView';
  static const bottomNavigationUi = '/bottomNavigationUi';
  static const boxGame = '/boxGame';

  static Route<dynamic>onRouteGenerate(RouteSettings settings){

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {

        switch (settings.name){

          case splashScreen:return SplashView();
          case homeView:return HomeView();
          case loginView:return LoginView();
          case bottomNavigationUi:return BottomNavigationUi();
          case boxGame:return BoxGame();

          default:return Scaffold(body: Center(child: Text("No route found")));
        }
      }
    );
  }
}
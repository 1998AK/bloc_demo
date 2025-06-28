import 'package:bloc_demo/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes{

  static const splashScreen = '/splashScreen';

  static Route<dynamic>onRouteGenerate(RouteSettings settings){

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {

        switch (settings.name){

          case splashScreen:return SplashView();
          default:return Scaffold(body: Center(child: Text("No route found")));
        }
      }
    );
  }
}
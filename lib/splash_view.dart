import 'package:bloc_demo/utils/app_bar_common.dart';
import 'package:bloc_demo/utils/app_color.dart';
import 'package:bloc_demo/utils/assets_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 2),(){

    });

    return Scaffold(
      backgroundColor: appColor,
      body: Center(
        child: Image.asset(AssetsName.logo),
      ),
    );
  }
}

import 'package:bloc_demo/utils/app_color.dart';
import 'package:bloc_demo/utils/app_routes.dart';
import 'package:bloc_demo/utils/assets_name.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushNamed(context, AppRoutes.loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Center(
        child: Image.asset(AssetsName.logo),
      ),
    );
  }
}

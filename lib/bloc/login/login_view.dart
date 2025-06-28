import 'package:bloc_demo/utils/assets_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(AssetsName.home),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

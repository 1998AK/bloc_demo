import 'package:bloc_demo/utils/app_color.dart';
import 'package:bloc_demo/utils/app_routes.dart';
import 'package:bloc_demo/utils/assets_name.dart';
import 'package:bloc_demo/utils/other.dart';
import 'package:bloc_demo/utils/share_pref.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/login_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref){
      String data = pref.getString(loginInfo) ?? '';
      Future.delayed(const Duration(seconds: 2), () {
        if(data.isNotEmpty){
          loginModel = loginModelFromJson(data);
          debugPrint("name is ${loginModel?.user?.name}");
          if(mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.bottomNavigationUi,
                  (route) => false,
            );
            // Navigator.pushNamed(context, AppRoutes.boxGame);
          }
        }
        else{
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginView,
                  (route) => false,
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Center(
        child: FlutterLogo(size: 100,),
      ),
    );
  }
}

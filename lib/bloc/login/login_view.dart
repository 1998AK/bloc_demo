import 'package:bloc_demo/utils/assets_name.dart';
import 'package:bloc_demo/utils/common_text_widget.dart';
import 'package:bloc_demo/utils/screen_width_dynamic.dart';
import 'package:bloc_demo/utils/smart_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_color.dart';
import '../../utils/common_elevated_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(sizeOfReturnValue(size: 20)),
            child: Center(
              child: Column(
                children: [
                  addVerticalSpace(height: 10),
                  SvgPicture.asset(AssetsName.home),
                  addVerticalSpace(height: 10),
                  CommonTextWidget(text: "Log in",color: loginColor,fontWeight: FontWeight.w600,fontSize: 22,),
                  addVerticalSpace(height: 10),
                  CommonTextWidget(text: "Welcome back!",color: welcomeBackColor,fontSize: 14,),
                  addVerticalSpace(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonTextWidget(text: "Don't have an account? ",color: welcomeBackColor,fontSize: 14,),
                      CommonTextWidget(text: "Sign up",color: appColor,fontSize: 14,),
            
                    ],
                  ),
                  addVerticalSpace(height: 10),
                  Container(
                    // alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: sizeOfReturnValue(size: 20),right: sizeOfReturnValue(size: 20)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(sizeOfReturnValue(size: 25)),bottomLeft: Radius.circular(sizeOfReturnValue(size: 25)),bottomRight: Radius.circular(sizeOfReturnValue(size: 25))),
                      border: Border.all(color: loginBorderColor)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addVerticalSpace(height: 10),
                        CommonTextWidget(text: "Phone number",fontWeight: FontWeight.w600,fontSize: 12,color: labelShowTextColor,),
                        SmartTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: TextFormFieldStyle.commonStyleApp(hindText: "+91 9876543210",prefix: SvgPicture.asset(AssetsName.phoneIcon,height: sizeOfReturnValue(size: 16))),
                        ),
                        addVerticalSpace(height: 10),
                        CommonTextWidget(text: "Password",fontWeight: FontWeight.w600,fontSize: 12,color: labelShowTextColor,),
                        SmartTextField(
                          showEyeIcon: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: TextFormFieldStyle.commonStyleApp(hindText: "***********",prefix: SvgPicture.asset(AssetsName.keyIcon,height: sizeOfReturnValue(size: 16))),
                        ),
                        addVerticalSpace(height: 10),
                        CommonTextWidget(text: "Forgot you password?",color: forgotPasswordColor,fontSize: 12,),
                        addVerticalSpace(height: 10),

                        CommonElevatedButton(
                          text: "Log in",
                          onPressed: () {},
                        ),
                        addVerticalSpace(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

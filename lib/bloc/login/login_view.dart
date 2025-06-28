import 'package:bloc_demo/bloc/login/login_bloc.dart';
import 'package:bloc_demo/bloc/login/login_events.dart';
import 'package:bloc_demo/bloc/login/login_states.dart';
import 'package:bloc_demo/utils/assets_name.dart';
import 'package:bloc_demo/utils/common_text_widget.dart';
import 'package:bloc_demo/utils/screen_width_dynamic.dart';
import 'package:bloc_demo/utils/smart_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/app_color.dart';
import '../../utils/app_routes.dart';
import '../../utils/common_elevated_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final mobileNoController = TextEditingController(text: '9876543210');
    final passwordController = TextEditingController(text: '123456');
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body:BlocConsumer<LoginBloc,LoginState>(

          listener: (context,state){

            if (state is LoginLoading) {
              // Show loader
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(color: appColor,),
                ),
              );
            }
            else {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if(state is LoginSuccess){
              Navigator.pushNamed(context, AppRoutes.bottomNavigationUi);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${state.loginModel.user?.name} Login Successful')),
              );
            }
            else if(state is LoginFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }

          },
          builder: (context,state){
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(sizeOfReturnValue(size: 20)),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        addVerticalSpace(height: 10),
                        SvgPicture.asset(AssetsName.home),
                        addVerticalSpace(height: 10),
                        CommonTextWidget(
                          text: "Log in",
                          color: loginColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                        addVerticalSpace(height: 10),
                        CommonTextWidget(
                          text: "Welcome back!",
                          color: welcomeBackColor,
                          fontSize: 14,
                        ),
                        addVerticalSpace(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonTextWidget(
                              text: "Don't have an account? ",
                              color: welcomeBackColor,
                              fontSize: 14,
                            ),
                            CommonTextWidget(
                              text: "Sign up",
                              color: appColor,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        addVerticalSpace(height: 10),
                        Container(
                          padding: EdgeInsets.only(
                            left: sizeOfReturnValue(size: 20),
                            right: sizeOfReturnValue(size: 20),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(sizeOfReturnValue(size: 25)),
                              bottomLeft: Radius.circular(sizeOfReturnValue(size: 25)),
                              bottomRight: Radius.circular(sizeOfReturnValue(size: 25)),
                            ),
                            border: Border.all(color: loginBorderColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addVerticalSpace(height: 10),
                              CommonTextWidget(
                                text: "Phone number",
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: labelShowTextColor,
                              ),
                              SmartTextField(
                                maxLength: 10,
                                controller: mobileNoController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: TextFormFieldStyle.commonStyleApp(
                                  hindText: "+91 9876543210",
                                  prefix: SvgPicture.asset(
                                    AssetsName.phoneIcon,
                                    height: sizeOfReturnValue(size: 16),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter a mobile number.";
                                  } else if (value.trim().length != 10) {
                                    return 'Mobile number must be 10 digit.';
                                  }
                                  return null;
                                },
                              ),
                              addVerticalSpace(height: 10),
                              CommonTextWidget(
                                text: "Password",
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: labelShowTextColor,
                              ),
                              SmartTextField(

                                controller: passwordController,
                                showEyeIcon: true,
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: TextFormFieldStyle.commonStyleApp(
                                  hindText: "***********",
                                  prefix: SvgPicture.asset(
                                    AssetsName.keyIcon,
                                    height: sizeOfReturnValue(size: 16),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a password";
                                  } else if (value.length < 6) {
                                    return "Password must be 6 digit";
                                  }
                                  return null;
                                },
                              ),
                              addVerticalSpace(height: 10),
                              CommonTextWidget(
                                text: "Forgot you password?",
                                color: forgotPasswordColor,
                                fontSize: 12,
                              ),
                              addVerticalSpace(height: 10),
                              CommonElevatedButton(
                                text: "Log in",
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                    context.read<LoginBloc>().add(
                                      LoginButtonPressed(
                                        mobileNo: mobileNoController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
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
            );
          },
        ),
      ),
    );
  }
}

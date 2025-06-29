import 'dart:convert';

import 'package:bloc_demo/bloc/login/login_events.dart';
import 'package:bloc_demo/bloc/login/login_states.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_demo/localdatabase/local_database.dart';
import 'package:bloc_demo/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_name.dart';
import '../../api/base_api_service.dart';
import '../../utils/other.dart';
import '../../utils/share_pref.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  final _api = NetworkServiceApi();

  LoginBloc():super(LoginInitial()){
    on<LoginButtonPressed>((event,emit) async{
      emit(LoginLoading());

      var data = {
        "email": "jayparmar181999@gmail.com",
        "password": "9133@Jaygp"
      };

      final apiResponse = await _api.postApi(url: login,data: data);

      if(apiResponse.statusCode == 200){
        var apiResponseJsonEncode = jsonEncode(apiResponse.data);
        await createTable();
        await Future.delayed(Duration(seconds: 2));
        await showALLTableField();
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString(loginInfo, apiResponseJsonEncode);
        loginModel = loginModelFromJson(apiResponseJsonEncode);
        emit(LoginSuccess(loginModelFromJson(apiResponseJsonEncode)));
      }
      else{
        emit(LoginFailure(apiResponse.errorMessage.toString()));
      }

    });
  }
}
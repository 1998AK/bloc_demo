import 'package:bloc_demo/bloc/login/login_events.dart';
import 'package:bloc_demo/bloc/login/login_states.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  LoginBloc():super(LoginInitial()){
    on<LoginButtonPressed>((event,emit) async{
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 3),(){
        emit(LoginSuccess());
      });
    });
  }
}
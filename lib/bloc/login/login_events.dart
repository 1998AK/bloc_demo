abstract class LoginEvent{}

class LoginButtonPressed extends LoginEvent{
  final String mobileNo,password;
  LoginButtonPressed({required this.mobileNo,required this.password});
}

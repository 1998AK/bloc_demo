// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newest_ak/l10n/localization_service.dart';
// import 'login_event.dart';
// import 'login_state.dart';
// import '../../Firebase/auth_email_service.dart';
// import '../../Firebase/firestore_user_service.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthService authService;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   bool isLogin = true;
//
//   LoginBloc({required this.authService}) : super(LoginInitial()) {
//     on<LoginButtonPressed>((event, emit) async {
//       emit(LoginLoading());
//       try {
//         if (event.isLogin) {
//           // Login Flow
//           UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//             email: event.email,
//             password: event.password,
//           );
//
//           if (userCredential.user != null && !userCredential.user!.emailVerified) {
//             await _auth.signOut();
//             emit(LoginFailure(language.pleaseVerifyYourEmailBeforeLoggingIn));
//           } else {
//             emit(LoginSuccess());
//           }
//         } else {
//           // Register Flow
//           var user = await authService.registerWithEmailPassword(
//             email: event.email,
//             password: event.password,
//           );
//           if (user != null) {
//
//             await user.sendEmailVerification();
//
//             // ✅ After successful registration, save user details to Firestore
//             await FirestoreUserService().saveUserDetails(
//               name: event.name ?? '',
//               mobile: event.mobile ?? '',
//             );
//
//             emit(LoginSuccess());
//           } else {
//             emit(LoginFailure(language.registrationFailed));
//           }
//         }
//       } catch (e) {
//         emit(LoginFailure(e.toString()));
//       }
//     });
//
//     on<ToggleAuthMode>((event, emit) {
//       isLogin = !isLogin;
//       emit(LoginInitial());
//     });
//   }
// }


//
// firebase_core: ^3.12.1
// firebase_auth: ^5.5.1
// cloud_firestore: ^5.6.7
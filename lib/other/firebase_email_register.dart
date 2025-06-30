// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:newest_ak/l10n/localization_service.dart';
// import 'registration_event.dart';
// import 'registration_state.dart';
//
// class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   RegistrationBloc() : super(RegistrationInitial()) {
//     on<RegisterEvent>(_onRegister);
//   }
//
//   Future<void> _onRegister(
//       RegisterEvent event,
//       Emitter<RegistrationState> emit,
//       ) async {
//     emit(RegistrationLoading());
//
//     if (event.password != event.confirmPassword) {
//       emit(RegistrationFailure(language.passwordsDoNotMatch));
//       return;
//     }
//
//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//
//       // Send verification email
//       await userCredential.user?.sendEmailVerification();
//
//       emit(RegistrationSuccess(language.registeredSuccessfullyPleaseVerifyYorEmail));
//     } on FirebaseAuthException catch (e) {
//       emit(RegistrationFailure(e.message ?? language.registrationFailed));
//     } catch (e) {
//       emit(RegistrationFailure(language.anUnexpectedErrorOccurred));
//     }
//   }
// }

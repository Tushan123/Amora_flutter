import 'package:amora/repositories/auth/auth_repository.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  SignupCubit(
      {required AuthRepository authRepository,
      required DatabaseRepository databaseRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void phonenoChanged(auth.PhoneAuthCredential otp) {
    emit(state.copyWith(cred: otp, status: SignUpStatus.inital));
  }

  Future<void> signupwithCredentials() async {
    try {
      var user = await _authRepository.signUp(cred: state.cred!);
      emit(state.copyWith(status: SignUpStatus.success, user: user));
    } catch (_) {}
  }
}

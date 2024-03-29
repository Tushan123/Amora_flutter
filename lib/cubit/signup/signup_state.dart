part of 'signup_cubit.dart';

enum SignUpStatus { inital, submitting, success, error }

// ignore: must_be_immutable
class SignupState extends Equatable {
  final auth.PhoneAuthCredential? cred;
  final SignUpStatus status;
  final auth.User? user;
  const SignupState({required this.cred, required this.status, this.user});

  factory SignupState.initial() {
    return const SignupState(
        cred: null, status: SignUpStatus.inital, user: null);
  }

  SignupState copyWith(
      {auth.PhoneAuthCredential? cred, SignUpStatus? status, auth.User? user}) {
    return SignupState(
        cred: cred ?? this.cred,
        status: status ?? this.status,
        user: user ?? this.user);
  }

  @override
  List<Object?> get props => [cred, status, user];
}

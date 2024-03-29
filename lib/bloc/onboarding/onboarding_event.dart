part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {}

class StartOnBoarding extends OnboardingEvent {
  final User user;

  StartOnBoarding({this.user = User.empty});
}

class UpdateUser extends OnboardingEvent {
  final User user;

  UpdateUser({required this.user});
}

class UpdateImages extends OnboardingEvent {
  final User? user;
  final XFile img;

  UpdateImages({this.user, required this.img});
}

class DeleteImages extends OnboardingEvent {
  final User? user;
  final Map<String, dynamic> img;

  DeleteImages({required this.user, required this.img});
}

class UpdateInterest extends OnboardingEvent {
  final User? user;
  final String interest;

  UpdateInterest({this.user, required this.interest});
}

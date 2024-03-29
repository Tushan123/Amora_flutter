part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnBoardingLoaded extends OnboardingState {
  final User user;

  OnBoardingLoaded({required this.user});
}

part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;

  ProfileLoaded({required this.user});
}

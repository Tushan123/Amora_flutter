part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userId;

  LoadProfile({required this.userId});
}

class UpdateUserProfile extends ProfileEvent {
  final User user;

  UpdateUserProfile({required this.user});
}

// class EditProfile extends ProfileEvent {
//   final bool isEditingOn;

//   EditProfile({required this.isEditingOn});
// }

class DeleteImageFromProfile extends ProfileEvent {
  final User user;
  final Map<String, dynamic> img;

  DeleteImageFromProfile({required this.user, required this.img});
}

class AddInterest extends ProfileEvent {
  final User user;
  final String interest;

  AddInterest({required this.user, required this.interest});
}

class DeleteInterest extends ProfileEvent {
  final User user;
  final String interest;

  DeleteInterest({required this.user, required this.interest});
}

class SaveProfile extends ProfileEvent {
  final User user;

  SaveProfile({required this.user});
}

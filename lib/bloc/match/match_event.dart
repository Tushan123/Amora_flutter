part of 'match_bloc.dart';

sealed class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class LoadMatches extends MatchEvent {
  final User user;

  const LoadMatches({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateMatches extends MatchEvent {
  final List<UserMatch> matchedUser;

  const UpdateMatches({required this.matchedUser});

  @override
  List<Object> get props => [matchedUser];
}

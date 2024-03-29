import 'dart:async';

import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/models/model.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubscription;
  StreamSubscription? _authSubscription;
  MatchBloc(
      {required DatabaseRepository databaseRepository,
      required AuthBloc authBloc})
      : _databaseRepository = databaseRepository,
        super(MatchLoading()) {
    on<LoadMatches>(_onLoadMatches);
    on<UpdateMatches>(_onUpdateMatches);

    _authSubscription = authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadMatches(user: state.user!));
      }
    });
  }

  FutureOr<void> _onLoadMatches(LoadMatches event, Emitter<MatchState> emit) {
    _databaseSubscription =
        _databaseRepository.getMatch(event.user).listen((matchedUser) {
      add(UpdateMatches(matchedUser: matchedUser));
    });
  }

  FutureOr<void> _onUpdateMatches(
      UpdateMatches event, Emitter<MatchState> emit) {
    if (event.matchedUser.isEmpty) {
      emit(MatchUnavailable());
    } else {
      emit(MatchLoaded(matches: event.matchedUser));
    }
  }

  @override
  Future<void> close() async {
    _databaseSubscription?.cancel();
    _authSubscription?.cancel();
    super.close();
  }
}

// ignore_for_file: void_checks
import 'dart:async';
import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/model.dart';
part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;
  SwipeBloc(
      {required AuthBloc authBloc,
      required DatabaseRepository databaseRepository})
      : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUserEvent>(_onLoadUser);
    on<UpdateSwipeScreen>(_onUpdateSwipeScreen);
    on<SwipeLeftEvent>(_mapSwipeLeftToState);
    on<SwipeRightEvent>(_mapSwipeRightToState);

    _authSubscription = authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadUserEvent(user: state.user!));
      }
    });
  }
  FutureOr<void> _onLoadUser(LoadUserEvent event, Emitter<SwipeState> emit) {
    _databaseRepository.getUserToSwipe(event.user).listen((users) {
      add(UpdateSwipeScreen(users: users));
    });
  }

  FutureOr<void> _onUpdateSwipeScreen(
      UpdateSwipeScreen event, Emitter<SwipeState> emit) {
    if (event.users.isNotEmpty) {
      emit(SwipeLoaded(users: event.users));
    } else {
      emit(SwipeError());
    }
  }

  FutureOr<void> _mapSwipeLeftToState(
      SwipeLeftEvent event, Emitter<SwipeState> emit) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      List<User> users = List.from(state.users)..remove(event.user);
      _databaseRepository.updateUserSwipe(
          _authBloc.state.authUser!.uid, event.user.id, false);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  FutureOr<void> _mapSwipeRightToState(
      SwipeRightEvent event, Emitter<SwipeState> emit) async {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);
      _databaseRepository.updateUserSwipe(userId, event.user.id, true);

      if (event.user.swipeRight!.contains(userId)) {
        await _databaseRepository.updateUserMatch(userId, event.user.id);
        emit(SwipeMatched(user: event.user));
      } else if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}

import 'dart:async';

import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/models/model.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/repositories/storage/storage_repository.dart';
import 'package:bloc/bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;
  StreamSubscription? _authSubscription;
  ProfileBloc(
      {required AuthBloc authBloc,
      required DatabaseRepository databaseRepository,
      required StorageRepository storageRepository})
      : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<DeleteImageFromProfile>(_onDeletImage);
    on<AddInterest>(_onAddInterest);
    on<DeleteInterest>(_onDeleteInterest);
    on<SaveProfile>(_onSaveProfile);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user != null) {
        add(LoadProfile(userId: state.authUser!.uid));
      }
    });
  }

  FutureOr<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    User user = await _databaseRepository.getUser(event.userId).first;
    emit(ProfileLoaded(user: user));
  }

  FutureOr<void> _onUpdateUserProfile(
      UpdateUserProfile event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      emit(ProfileLoaded(user: event.user));
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }

  FutureOr<void> _onSaveProfile(SaveProfile event, Emitter<ProfileState> emit) {
    if (state is ProfileLoaded) {
      _databaseRepository.updateUser((state as ProfileLoaded).user);
      emit(ProfileLoaded(user: (state as ProfileLoaded).user));
    }
  }

  FutureOr<void> _onDeletImage(
      DeleteImageFromProfile event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final user = (state as ProfileLoaded).user;

      await _storageRepository.deleteImage(user, event.img);
      _databaseRepository.getUser(user.id).listen((user1) {
        add(UpdateUserProfile(user: user1));
      });
    }
  }

  FutureOr<void> _onAddInterest(
      AddInterest event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final user = (state as ProfileLoaded).user;

      await _databaseRepository.updateUserInterest(user, event.interest, true);
      _databaseRepository.getUser(user.id).listen((user1) {
        add(UpdateUserProfile(user: user1));
      });
    }
  }

  FutureOr<void> _onDeleteInterest(
      DeleteInterest event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final user = (state as ProfileLoaded).user;

      await _databaseRepository.updateUserInterest(user, event.interest, false);
      _databaseRepository.getUser(user.id).listen((user1) {
        add(UpdateUserProfile(user: user1));
      });
    }
  }
}

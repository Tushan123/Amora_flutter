import 'dart:async';

import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/repositories/storage/storage_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;
  OnboardingBloc(
      {required DatabaseRepository databaseRepository,
      required StorageRepository storageRepository})
      : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        super(OnboardingLoading()) {
    on<StartOnBoarding>(_startOnBoarding);
    on<UpdateUser>(_updateUser);
    on<UpdateImages>(_updateImages);
    on<DeleteImages>(_deleteImages);
    on<UpdateInterest>(_updateInterest);
  }

  FutureOr<void> _startOnBoarding(
      StartOnBoarding event, Emitter<OnboardingState> emit) async {
    await _databaseRepository.createUser(event.user);
    emit(OnBoardingLoaded(user: event.user));
  }

  FutureOr<void> _updateUser(UpdateUser event, Emitter<OnboardingState> emit) {
    if (state is OnBoardingLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(OnBoardingLoaded(user: event.user));
    }
  }

  FutureOr<void> _updateImages(
      UpdateImages event, Emitter<OnboardingState> emit) async {
    if (state is OnBoardingLoaded) {
      final user = (state as OnBoardingLoaded).user;

      await _storageRepository.uploadImage(user, event.img);
      _databaseRepository.getUser(user.id).listen((user1) {
        add(UpdateUser(user: user1));
      });
    }
  }

  FutureOr<void> _updateInterest(
      UpdateInterest event, Emitter<OnboardingState> emit) async {
    if (state is OnBoardingLoaded) {
      final user = (state as OnBoardingLoaded).user;

      await _databaseRepository.updateUserInterest(user, event.interest, true);
      _databaseRepository.getUser(user.id).listen((user1) {
        add(UpdateUser(user: user1));
      });
    }
  }

  FutureOr<void> _deleteImages(
      DeleteImages event, Emitter<OnboardingState> emit) async {
    if (state is OnBoardingLoaded) {
      final user = (state as OnBoardingLoaded).user;

      await _storageRepository.deleteImage(user, event.img);
      _databaseRepository.getUser(user.id).listen((user1) {
        add(UpdateUser(user: user1));
      });
    }
  }
}

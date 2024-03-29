import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/bloc/profile/profile_bloc.dart';
import 'package:amora/bloc/swipe/swipe_bloc.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/repositories/storage/storage_repository.dart';
import 'package:amora/screens/onboarding/onboard_screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferenceScreen extends StatelessWidget {
  const PreferenceScreen({super.key});

  static const String routeName = "/preference";

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.unauthenticated
            ? const Start()
            : BlocProvider<ProfileBloc>(
                create: (context) => ProfileBloc(
                    authBloc: BlocProvider.of<AuthBloc>(context),
                    databaseRepository: context.read<DatabaseRepository>(),
                    storageRepository: context.read<StorageRepository>())
                  ..add(
                    LoadProfile(
                        userId: context.read<AuthBloc>().state.authUser!.uid),
                  ),
                child: const PreferenceScreen(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 217, 10),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Your Preferences",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: _GenderSelection(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: _AgeSelection(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 248, 245),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(SaveProfile(user: state.user));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}

class _GenderSelection extends StatelessWidget {
  const _GenderSelection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return SizedBox(
          //   height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Who you want to date",
                  style: TextStyle(
                      fontFamily: 'Superior',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value:
                                  state.user.genderPrefered!.contains('Male'),
                              onChanged: (value) {
                                if (state.user.genderPrefered!
                                    .contains('Male')) {
                                  context.read<ProfileBloc>().add(
                                      UpdateUserProfile(
                                          user: state.user.copyWith(
                                              genderPrefered: List.from(
                                                  state.user.genderPrefered!)
                                                ..remove('Male'))));
                                  BlocProvider.of<SwipeBloc>(context)
                                      .add(LoadUserEvent(user: state.user));
                                } else {
                                  context.read<ProfileBloc>().add(
                                      UpdateUserProfile(
                                          user: state.user.copyWith(
                                              genderPrefered: List.from(
                                                  state.user.genderPrefered!)
                                                ..add('Male'))));
                                  BlocProvider.of<SwipeBloc>(context)
                                      .add(LoadUserEvent(user: state.user));
                                }
                              }),
                          const Text(
                            "Male",
                            style:
                                TextStyle(fontFamily: 'Couture', fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value:
                                  state.user.genderPrefered!.contains('Female'),
                              onChanged: (value) {
                                if (state.user.genderPrefered!
                                    .contains('Female')) {
                                  context.read<ProfileBloc>().add(
                                      UpdateUserProfile(
                                          user: state.user.copyWith(
                                              genderPrefered: List.from(
                                                  state.user.genderPrefered!)
                                                ..remove('Female'))));
                                  BlocProvider.of<SwipeBloc>(context)
                                      .add(LoadUserEvent(user: state.user));
                                } else {
                                  context.read<ProfileBloc>().add(
                                      UpdateUserProfile(
                                          user: state.user.copyWith(
                                              genderPrefered: List.from(
                                                  state.user.genderPrefered!)
                                                ..add('Female'))));
                                  BlocProvider.of<SwipeBloc>(context)
                                      .add(LoadUserEvent(user: state.user));
                                }
                              }),
                          const Text(
                            "Female",
                            style:
                                TextStyle(fontFamily: 'Couture', fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: state.user.genderPrefered!
                                  .contains('Non-binary'),
                              onChanged: (value) {
                                if (state.user.genderPrefered!
                                    .contains('Non-binary')) {
                                  context.read<ProfileBloc>().add(
                                      UpdateUserProfile(
                                          user: state.user.copyWith(
                                              genderPrefered: List.from(
                                                  state.user.genderPrefered!)
                                                ..remove('Non-binary'))));
                                  BlocProvider.of<SwipeBloc>(context)
                                      .add(LoadUserEvent(user: state.user));
                                } else {
                                  context.read<ProfileBloc>().add(
                                      UpdateUserProfile(
                                          user: state.user.copyWith(
                                              genderPrefered: List.from(
                                                  state.user.genderPrefered!)
                                                ..add('Non-binary'))));
                                  BlocProvider.of<SwipeBloc>(context)
                                      .add(LoadUserEvent(user: state.user));
                                }
                              }),
                          const Text(
                            "Non-Binary",
                            style:
                                TextStyle(fontFamily: 'Couture', fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _AgeSelection extends StatelessWidget {
  const _AgeSelection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        state as ProfileLoaded;
        return SizedBox(
          // height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "Age",
                  style: TextStyle(
                      fontFamily: 'Superior',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Text(
                          "Between ${state.user.agePrefered![0].toString()} - ${state.user.agePrefered![1].toString()}",
                          style: const TextStyle(
                              fontFamily: "Couture", fontSize: 18),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: RangeSlider(
                            values: RangeValues(
                                state.user.agePrefered![0].toDouble(),
                                state.user.agePrefered![1].toDouble()),
                            min: 18,
                            max: 60,
                            activeColor: Colors.black,
                            inactiveColor: Colors.black,
                            onChanged: (rangeValue) {
                              context.read<ProfileBloc>().add(UpdateUserProfile(
                                      user: state.user.copyWith(agePrefered: [
                                    rangeValue.start.toInt(),
                                    rangeValue.end.toInt()
                                  ])));
                            },
                            onChangeEnd: (RangeValues newVal) {},
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

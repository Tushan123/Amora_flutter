import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/bloc/match/match_bloc.dart';
import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:amora/bloc/profile/profile_bloc.dart';
import 'package:amora/bloc/swipe/swipe_bloc.dart';
import 'package:amora/config/app_router.dart';
import 'package:amora/cubit/signup/signup_cubit.dart';
import 'package:amora/firebase_options.dart';
import 'package:amora/models/model.dart';
import 'package:amora/repositories/auth/auth_repository.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/repositories/storage/storage_repository.dart';
import 'package:amora/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Amora());
}

class Amora extends StatefulWidget {
  const Amora({super.key});

  @override
  State<Amora> createState() => _AmoraState();
}

class _AmoraState extends State<Amora> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => DatabaseRepository()),
        RepositoryProvider(create: (context) => StorageRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                  authRepository: context.read<AuthRepository>(),
                  databaseRepository: context.read<DatabaseRepository>())),
          BlocProvider<SignupCubit>(
              create: (context) => SignupCubit(
                  authRepository: context.read<AuthRepository>(),
                  databaseRepository: context.read<DatabaseRepository>())),
          BlocProvider(
              create: (context) => ProfileBloc(
                  authBloc: context.read<AuthBloc>(),
                  databaseRepository: context.read<DatabaseRepository>(),
                  storageRepository: context.read<StorageRepository>())
                ..add(LoadProfile(
                    userId: context.read<AuthBloc>().state.authUser!.uid))),
          BlocProvider(
              create: (context) => OnboardingBloc(
                  databaseRepository: context.read<DatabaseRepository>(),
                  storageRepository: context.read<StorageRepository>())),
          BlocProvider<MatchBloc>(
              create: (context) => MatchBloc(
                    databaseRepository: context.read<DatabaseRepository>(),
                    authBloc: context.read<AuthBloc>(),
                  )..add(
                      LoadMatches(user: context.read<AuthBloc>().state.user!))),
          BlocProvider<SwipeBloc>(
              create: (context) => SwipeBloc(
                    authBloc: context.read<AuthBloc>(),
                    databaseRepository: context.read<DatabaseRepository>(),
                  )..add(LoadUserEvent(
                      user: User(
                          id: context.read<AuthBloc>().state.user!.id,
                          name: context.read<AuthBloc>().state.user!.name,
                          age: context.read<AuthBloc>().state.user!.age,
                          imageUrls:
                              context.read<AuthBloc>().state.user!.imageUrls,
                          bio: context.read<AuthBloc>().state.user!.bio,
                          jobTitle:
                              context.read<AuthBloc>().state.user!.jobTitle,
                          location:
                              context.read<AuthBloc>().state.user!.location,
                          gender: context.read<AuthBloc>().state.user!.gender,
                          swipeLeft:
                              context.read<AuthBloc>().state.user!.swipeLeft,
                          swipeRight:
                              context.read<AuthBloc>().state.user!.swipeRight,
                          agePrefered:
                              context.read<AuthBloc>().state.user!.agePrefered,
                          genderPrefered: context
                              .read<AuthBloc>()
                              .state
                              .user!
                              .genderPrefered,
                          matches:
                              context.read<AuthBloc>().state.user!.matches))))
        ],
        child: const MaterialApp(
          title: "Amora",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}

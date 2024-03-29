import 'dart:async';
import 'package:amora/screens/home/home_screen.dart';
import 'package:amora/screens/onboarding/onboard_screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = "/splash";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: ((context) => const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // print("Listener : ${state.status}");
        if (state.status == AuthStatus.unauthenticated) {
          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                  Start.routeName, ModalRoute.withName("/start")));
        } else if (state.status == AuthStatus.authenticated) {
          Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context)
                  .pushReplacementNamed(HomeScreen.routeName));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.amberAccent,
        body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Image.asset("assets/images/logo-no-background.png")),
        ),
      ),
    );
  }
}

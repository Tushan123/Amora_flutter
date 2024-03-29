import 'package:amora/models/model.dart';
import 'package:amora/screens/chat/chat_screen.dart';
import 'package:amora/screens/home/home_screen.dart';
import 'package:amora/screens/match/match_screen.dart';
import 'package:amora/screens/onboarding/onboard_screens/interests_screen.dart';
import 'package:amora/screens/onboarding/onboard_screens/start_screen.dart';
import 'package:amora/screens/preferences/preferences_screen.dart';
import 'package:amora/screens/profile/profile.dart';
import 'package:amora/screens/splash/splash_screen.dart';
import 'package:amora/screens/user/user_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print("The Route is ${settings.name}");
    }

    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case InterestsScreen.routeName:
        return InterestsScreen.route();
      case MatchScreen.routeName:
        return MatchScreen.route();
      case UserScreen.routeName:
        return UserScreen.route();
      case Start.routeName:
        return Start.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case PreferenceScreen.routeName:
        return PreferenceScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route(userMatch: settings.arguments as UserMatch);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
                appBar: AppBar(
              title: const Text("Error"),
            )),
        settings: const RouteSettings(name: '/error'));
  }
}

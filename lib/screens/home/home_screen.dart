import 'package:amora/repositories/auth/auth_repository.dart';
import 'package:amora/screens/match/match_screen.dart';
import 'package:amora/screens/preferences/preferences_screen.dart';

import 'package:amora/screens/swipe_screen/swipe_screen.dart';
import 'package:amora/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return const HomeScreen();
    });
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> _screens = [
    UserScreen(),
    // Premium(),
    SwipeScreen(),
    MatchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 13,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: selectedIndex == 2 && selectedIndex == 0
              ? const Color(0xFFFBC117)
              : Colors.transparent,
          title: SizedBox(
            width: 200,
            child: Image.asset(
              "assets/images/logo-no-background.png",
              color: Colors.amber,
              fit: BoxFit.cover,
            ),
          ),
          actions: (selectedIndex == 0)
              ? [
                  IconButton(
                      onPressed: () {
                        RepositoryProvider.of<AuthRepository>(context)
                            .signOut();
                        Navigator.pushReplacementNamed(context, "/start");
                      },
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                        size: 30,
                      ))
                ]
              : [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PreferenceScreen.routeName);
                      },
                      icon: const Icon(
                        Ionicons.filter,
                        color: Colors.black,
                        size: 30,
                      )),
                ]),
      body: _screens.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFBC117),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                gap: 3,
                activeColor: const Color(0xFFFBC117),
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 900),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.white,
                haptic: true,
                tabs: const [
                  GButton(
                    icon: Ionicons.person,
                  ),
                  GButton(
                    icon: Ionicons.home,
                  ),
                  GButton(icon: Ionicons.chatbubble),
                ],
                selectedIndex: selectedIndex,
                onTabChange: onItemTapped),
          ),
        ),
      ),
    );
  }
}

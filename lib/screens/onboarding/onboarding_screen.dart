// import 'package:amora/screens/onboarding/onboard_screens/bio_screen.dart';
// import 'package:amora/screens/onboarding/onboard_screens/demo_screen.dart';
// import 'package:amora/screens/onboarding/onboard_screens/email_screen%20.dart';
// import 'package:amora/screens/onboarding/onboard_screens/email_verification.dart';
// import 'package:amora/screens/onboarding/onboard_screens/genderAge.dart';
// import 'package:amora/screens/onboarding/onboard_screens/interests_screen.dart';
// import 'package:amora/screens/onboarding/onboard_screens/pictures_screen.dart';
// import 'package:amora/screens/onboarding/onboard_screens/start_screen.dart';
// import 'package:flutter/material.dart';

// class OnBoardingScreen extends StatefulWidget {
//   static const String routeName = "/onboarding";
//   static Route route() {
//     return MaterialPageRoute(
//         settings: RouteSettings(name: routeName),
//         builder: (context) => OnBoardingScreen());
//   }

//   const OnBoardingScreen({super.key});

//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 10,
//       child: Builder(builder: (BuildContext context) {
//         final TabController tabController = DefaultTabController.of(context);
//         tabController.addListener(() {
//           if (!tabController.indexIsChanging) {}
//         });
//         return Scaffold(
//           backgroundColor: const Color(0xFFFBC117),
//           body: TabBarView(children: [
//             Start(
//               tabController: tabController,
//             ),
//             EmailScreen(tabController: tabController),
//             VerificationScreen(tabController: tabController),
//             DemoScreen(),
//             AgeScreen(
//               tabController: tabController,
//             ),
//             GenderScreen(tabController: tabController),
//             PicturesScreen(
//               tabController: tabController,
//             ),
//             BioScreen(tabController: tabController),
//             InterestsScreen(tabController: tabController)
//           ]),
//         );
//       }),
//     );
//   }
// }

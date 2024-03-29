import 'package:amora/screens/onboarding/widgets/customButton.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  static const String routeName = "/start";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: ((context) => const Start()));
  }

  const Start({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBC117),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo-no-background.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Welcome to the World of Love",
                      style: TextStyle(
                          fontFamily: "CarterOne",
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    CustomButton(),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: Text(
                          "By signing up, you agree to our Terms. See how we use your data in our Privacy Policy."),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

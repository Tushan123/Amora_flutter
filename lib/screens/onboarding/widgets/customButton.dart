// ignore_for_file: file_names
import 'package:amora/screens/onboarding/onboard_screens/phone_screen.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const PhoneScreen()));
            },
            child: const SizedBox(
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Sign In using Phone Number",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Superior",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )));
  }
}

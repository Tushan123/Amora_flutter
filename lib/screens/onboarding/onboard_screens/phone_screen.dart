import 'package:amora/screens/onboarding/onboard_screens/otp_verification.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({
    super.key,
  });

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  var phone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBC117),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 15, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StepProgressIndicator(
                    totalSteps: 9,
                    currentStep: 1,
                    selectedColor: Colors.black,
                    unselectedColor: Colors.transparent,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "What's your number ?",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "We protect our community by making sure everyone on Amora is real."),
                  const SizedBox(
                    height: 15,
                  ),
                  UserInput(
                    onChange: (value) {
                      phone = value;
                    },
                    text: 'Phone No.',
                    type: TextInputType.phone,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Row(
                    children: [
                      Icon(Ionicons.lock_closed),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                            "We never share this with anyone and it won't be on your profile"),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      print(phone);
                      await FirebaseAuth.instance.verifyPhoneNumber(
                          verificationCompleted:
                              (PhoneAuthCredential cred) async {},
                          verificationFailed: (FirebaseAuthException ex) {},
                          codeSent: (String verifyId, int? resentToken) async {
                            await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerificationScreen(
                                          verifyId: verifyId,
                                          phone: phone,
                                        )));
                            print("Code Sent");
                          },
                          codeAutoRetrievalTimeout: (String verifyId) {},
                          phoneNumber: phone);
                    },
                    icon: const Icon(Ionicons.arrow_forward))
              ],
            )
          ],
        ),
      ),
    );
  }
}

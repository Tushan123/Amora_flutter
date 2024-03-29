import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:amora/cubit/signup/signup_cubit.dart';
import 'package:amora/models/model.dart' as u;
import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/screens/home/home_screen.dart';
import 'package:amora/screens/onboarding/onboard_screens/demo_screen.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class VerificationScreen extends StatefulWidget {
  final String verifyId;
  final String phone;
  const VerificationScreen(
      {super.key, required this.verifyId, required this.phone});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBC117),
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 15, 15),
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
                        currentStep: 2,
                        selectedColor: Colors.black,
                        unselectedColor: Colors.transparent,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Verify your number",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                          "Enter the code we've sent by text to ${widget.phone}."),
                      const SizedBox(
                        height: 20,
                      ),
                      UserInput(
                        text: "Code",
                        type: TextInputType.number,
                        onChange: (value) {
                          PhoneAuthCredential cred =
                              PhoneAuthProvider.credential(
                                  verificationId: widget.verifyId,
                                  smsCode: value);
                          context.read<SignupCubit>().phonenoChanged(cred);
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text("Didn't get a code?"),
                      ],
                    ),
                    IconButton(
                        onPressed: () async {
                          await context
                              .read<SignupCubit>()
                              .signupwithCredentials();
                          String uid =
                              // ignore: use_build_context_synchronously
                              context.read<SignupCubit>().state.user!.uid;
                          String result =
                              await DatabaseRepository().checkUser(uid);
                          if (result == "") {
                            u.User user = u.User(
                                id: uid,
                                name: "",
                                age: 0,
                                imageUrls: [],
                                bio: "",
                                interests: [],
                                jobTitle: "",
                                location: "",
                                matches: [],
                                swipeLeft: [],
                                swipeRight: [],
                                genderPrefered: [
                                  'Male',
                                  'Female',
                                  'Non-binary'
                                ],
                                agePrefered: [19, 40],
                                gender: "");
                            // ignore: use_build_context_synchronously
                            context
                                .read<OnboardingBloc>()
                                .add(StartOnBoarding(user: user));
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DemoScreen()));
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }
                        },
                        icon: const Icon(Ionicons.arrow_forward))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

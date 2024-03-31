// ignore_for_file: file_names
import 'dart:ffi';

import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:amora/screens/onboarding/onboard_screens/pictures_screen.dart';
import 'package:amora/screens/onboarding/widgets/customCheckBox.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({
    super.key,
  });

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  @override
  Widget build(BuildContext context) {
    String age = "";
    return Scaffold(
      backgroundColor: const Color(0xFFFBC117),
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OnBoardingLoaded) {
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
                          currentStep: 4,
                          selectedColor: Colors.black,
                          unselectedColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "What is your age?",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        UserInput(
                          text: "Age",
                          type: TextInputType.datetime,
                          onChange: (value) {
                            age = value;
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user
                                    .copyWith(age: int.parse(value))));
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
                          Icon(Ionicons.lock_closed),
                          SizedBox(
                            width: 15,
                          ),
                          Text("We only show your age to potential."),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            if (age.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Age is required for your profile")));
                            } else if (int.parse(age) < 18) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Age should be 18 or older")));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const GenderScreen()));
                            }
                          },
                          icon: const Icon(Ionicons.arrow_forward))
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

class GenderScreen extends StatefulWidget {
  const GenderScreen({
    super.key,
  });

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  late bool gender;
  @override
  void initState() {
    super.initState();
    gender = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBC117),
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OnBoardingLoaded) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 15, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StepProgressIndicator(
                          totalSteps: 9,
                          currentStep: 5,
                          selectedColor: Colors.black,
                          unselectedColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "What's your gender?",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Pick which describes you."),
                        const SizedBox(
                          height: 20,
                        ),
                        CheckBox(
                          text: "MAN",
                          onChange: (bool? newValue) {
                            setState(() {
                              gender = true;
                            });
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(gender: 'Male')));
                          },
                          value: state.user.gender == "Male",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CheckBox(
                          text: "WOMAN",
                          value: state.user.gender == "Female",
                          onChange: (bool? newValue) {
                            setState(() {
                              gender = true;
                            });
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(gender: 'Female')));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CheckBox(
                          text: "NON-BINARY",
                          value: state.user.gender == "Non-binary",
                          onChange: (bool? newValue) {
                            setState(() {
                              gender = true;
                            });
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user:
                                    state.user.copyWith(gender: 'Non-binary')));
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Ionicons.eye),
                          SizedBox(
                            width: 10,
                          ),
                          Text("This will help in finding your partner"),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            print(gender);
                            if (!gender) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Please select your gender")));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PicturesScreen()));
                            }
                          },
                          icon: const Icon(Ionicons.arrow_forward))
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }
}

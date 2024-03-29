import 'package:amora/screens/onboarding/onboard_screens/interests_screen.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StepProgressIndicator(
                          totalSteps: 9,
                          currentStep: 8,
                          selectedColor: Colors.black,
                          unselectedColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Where do you live?",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                            "Your location will be used to find partners near your location"),
                        const SizedBox(
                          height: 20,
                        ),
                        UserInput(
                          text: "Location",
                          type: TextInputType.text,
                          onChange: (value) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(location: value)));
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const Row(
                      //   children: [
                      //     Icon(Ionicons.bulb),
                      //     Text("Want some tips?"),
                      //   ],
                      // ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InterestsScreen()));
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

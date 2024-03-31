import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:amora/screens/onboarding/onboard_screens/location_screen.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({
    super.key,
  });

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
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
                          currentStep: 7,
                          selectedColor: Colors.black,
                          unselectedColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Tell us about yourself",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        UserInput(
                          text: "About Yourself",
                          type: TextInputType.text,
                          onChange: (value) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(bio: value)));
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        UserInput(
                          text: "Job Title(optional)",
                          type: TextInputType.text,
                          onChange: (value) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(jobTitle: value)));
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
                          Icon(Ionicons.bulb),
                          Text("Want some tips?"),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LocationScreen()));
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

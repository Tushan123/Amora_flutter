import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:amora/screens/onboarding/onboard_screens/genderAge.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({
    super.key,
  });

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
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
                          currentStep: 3,
                          selectedColor: Colors.black,
                          unselectedColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "What's your first name?",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("You won't be able to change this later."),
                        const SizedBox(
                          height: 20,
                        ),
                        UserInput(
                          text: "Nickname",
                          type: TextInputType.text,
                          onChange: (value) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(name: value)));
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
                          Icon(Ionicons.eye),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              width: 230,
                              child: Text(
                                  "Your name will be displayed in your profile.")),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AgeScreen()));
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

import 'package:amora/bloc/profile/profile_bloc.dart';
import 'package:amora/screens/home/home_screen.dart';
import 'package:amora/screens/onboarding/widgets/customInputField.dart';
import 'package:amora/widget/interest_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';

class InterestsScreen extends StatefulWidget {
  static const String routeName = '/interest';

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return const InterestsScreen();
    });
  }

  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
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
            TextEditingController interestController = TextEditingController();
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 15, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StepProgressIndicator(
                          totalSteps: 9,
                          currentStep: 9,
                          selectedColor: Colors.black,
                          unselectedColor: Colors.transparent,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Tell us about your interests",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                            "Interests will help you to know more about a person"),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            UserInput(
                              text: "Interests",
                              type: TextInputType.text,
                              controller: interestController,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(AddInterest(
                                                  user: state.user,
                                                  interest:
                                                      interestController.text));
                                          interestController.clear();
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                            children: state.user.interests!
                                .map((interest) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: InterestCard(
                                        interestName: interest,
                                        isEditing: true,
                                        onPressd: () {
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(DeleteInterest(
                                                  user: state.user,
                                                  interest: interest));

                                          // print("Pressed");
                                          // context.read<ProfileBloc>().add(
                                          //     DeleteInterest(
                                          //         user: state.user,
                                          //         interest: interest));
                                        },
                                      ),
                                    ))
                                .toList()),
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
                                    builder: (context) => const HomeScreen()));
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

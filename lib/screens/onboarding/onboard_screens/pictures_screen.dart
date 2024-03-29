import 'package:amora/bloc/onboarding/onboarding_bloc.dart';
import 'package:amora/screens/onboarding/onboard_screens/bio_screen.dart';
import 'package:amora/screens/onboarding/widgets/imageContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PicturesScreen extends StatefulWidget {
  const PicturesScreen({
    super.key,
  });

  @override
  State<PicturesScreen> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
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
            var images = state.user.imageUrls;
            var imageCount = images.length;
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 11, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StepProgressIndicator(
                        totalSteps: 9,
                        currentStep: 6,
                        selectedColor: Colors.black,
                        unselectedColor: Colors.transparent,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Upload your photos",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                          "Add atleast 2 or more photos for your profile"),
                      SizedBox(
                        height: 400,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.66,
                          ),
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return (imageCount > index)
                                ? ImageContainer(imgUrl: images[index]['url'])
                                : const ImageContainer();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Text(""),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BioScreen()));
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

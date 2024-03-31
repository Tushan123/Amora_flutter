import 'package:amora/bloc/profile/profile_bloc.dart';
import 'package:amora/widget/content_box.dart';
import 'package:amora/widget/interest_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const UserScreen();
        });
  }

  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.amber,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 255, 247, 201),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: state.user.imageUrls[0]['url'],
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(), // Placeholder widget while image is loading
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons
                                            .error), // Widget to display if image fails to load
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 145,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/profile");
                                },
                                child: Container(
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.amber,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit),
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "${state.user.name}, ${state.user.age}",
                          style: const TextStyle(
                              fontSize: 30, fontFamily: 'Couture'),
                        ),
                        Text(
                          state.user.jobTitle,
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'Couture'),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 3.5,
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 2, color: Colors.amber)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Ionicons.star,
                                    size: 30,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: Text(
                                      "${state.user.matches!.length} people liked your profile",
                                      style: const TextStyle(
                                          fontFamily: "Couture"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "About Me",
                                  style: TextStyle(
                                      fontFamily: "COuture", fontSize: 15),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: ContentBox(textData: state.user.bio),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Location",
                                  style: TextStyle(
                                      fontFamily: "Couture", fontSize: 15),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child:
                                      ContentBox(textData: state.user.location),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Text(
                            "Photos",
                            style:
                                TextStyle(fontFamily: "Couture", fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child: SizedBox(
                            height: 150,
                            child: ListView.builder(
                                itemCount: state.user.imageUrls.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: SizedBox(
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: state.user.imageUrls[index]
                                              ['url'],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            "assets/images/portrait.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Interests",
                                  style: TextStyle(
                                      fontFamily: "Couture", fontSize: 15),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 9),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: state.user.interests!
                                          .map((interest) => InterestCard(
                                                interestName: interest,
                                                onPressd: () {},
                                              ))
                                          .toList()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
          );
        } else {
          return const Text("Error");
        }
      },
    );
  }
}

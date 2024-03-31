import 'package:amora/bloc/profile/profile_bloc.dart';
import 'package:amora/screens/onboarding/widgets/imageContainer.dart';
import 'package:amora/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const ProfileScreen();
        });
  }

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController interestController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 217, 10),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 380,
                      child: GridView.builder(
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 100 / 150,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            if (index < state.user.imageUrls.length) {
                              return Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(state
                                                .user.imageUrls[index]['url']),
                                            fit: BoxFit.cover)),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Center(
                                          child: IconButton(
                                              onPressed: () {
                                                context.read<ProfileBloc>().add(
                                                    DeleteImageFromProfile(
                                                        user: state.user,
                                                        img: state.user
                                                            .imageUrls[index]));
                                              },
                                              iconSize: 15,
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const ImageContainer();
                            }
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        "About Me",
                        style: TextStyle(fontFamily: "COuture", fontSize: 15),
                      ),
                    ),
                    ProfileInputField(
                      type: TextInputType.name,
                      text: state.user.bio,
                      onChange: (value) {
                        context.read<ProfileBloc>().add(UpdateUserProfile(
                            user: state.user.copyWith(bio: value)));
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        "Job Title",
                        style: TextStyle(fontFamily: "Couture", fontSize: 15),
                      ),
                    ),
                    ProfileInputField(
                      type: TextInputType.name,
                      text: state.user.jobTitle,
                      onChange: (value) {
                        context.read<ProfileBloc>().add(UpdateUserProfile(
                            user: state.user.copyWith(jobTitle: value)));
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        "Location",
                        style: TextStyle(fontFamily: "COuture", fontSize: 15),
                      ),
                    ),
                    ProfileInputField(
                      type: TextInputType.name,
                      text: state.user.location,
                      onChange: (value) {
                        context.read<ProfileBloc>().add(UpdateUserProfile(
                            user: state.user.copyWith(location: value)));
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Text(
                        "Interests",
                        style: TextStyle(fontFamily: "COuture", fontSize: 15),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileInputField(
                            type: TextInputType.name,
                            text: " ",
                            controller: interestController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                      context.read<ProfileBloc>().add(
                                          AddInterest(
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
                      height: 5,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: state.user.interests!
                            .map((interest) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: InterestCard(
                                    interestName: interest,
                                    isEditing: true,
                                    onPressd: () {
                                      print("Pressed");
                                      context.read<ProfileBloc>().add(
                                          DeleteInterest(
                                              user: state.user,
                                              interest: interest));
                                    },
                                  ),
                                ))
                            .toList()),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 4,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 248, 191, 5),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(SaveProfile(user: state.user));
                                Navigator.pop(context);
                              },
                              child: const Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontFamily: "Couture",
                                      color: Colors.black),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text("Something went wroong");
          }
        },
      ),
    );
  }
}

class ProfileInputField extends StatelessWidget {
  final TextInputType type;
  final Function(String)? onChange;
  final String text;
  final TextEditingController? controller;
  const ProfileInputField(
      {super.key,
      required this.type,
      this.onChange,
      required this.text,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: const Color.fromARGB(255, 248, 191, 5),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white)),
          contentPadding: const EdgeInsets.all(20)),
    );
  }
}

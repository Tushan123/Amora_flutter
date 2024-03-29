import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../bloc/swipe/swipe_bloc.dart';
import '../../widget/widget.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];

  late MatchEngine _matchEngine;

  @override
  void initState() {
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SwipeLoaded) {
          for (int i = 0; i < state.users.length; i++) {
            _swipeItems.add(SwipeItem(
                content: UserCard(
                  user: state.users[i],
                  engine: _matchEngine,
                ),
                likeAction: () {
                  context
                      .read<SwipeBloc>()
                      .add(SwipeRightEvent(user: state.users[i]));
                },
                nopeAction: () {
                  context
                      .read<SwipeBloc>()
                      .add(SwipeLeftEvent(user: state.users[i]));
                }));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              height: 650,
              child: Center(
                child: SwipeCards(
                  matchEngine: _matchEngine,
                  onStackFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Stack Finished"),
                      duration: Duration(milliseconds: 5000),
                    ));
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: _swipeItems[index].content,
                    );
                  },
                  leftSwipeAllowed: true,
                  rightSwipeAllowed: true,
                ),
              ),
            ),
          );
        } else if (state is SwipeMatched) {
          return SizedBox(
            height: 660,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Congratulations!!",
                  style: TextStyle(fontSize: 30, fontFamily: "CarterOne"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                      "You and ${state.user.name} have liked each other",
                      style:
                          const TextStyle(fontSize: 15, fontFamily: "Libre")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.amber),
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: context
                                      .read<AuthBloc>()
                                      .state
                                      .user!
                                      .imageUrls[0]['url'],
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
                        ),
                      ),
                      ClipOval(
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.amber),
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 50,
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
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () {
                          context.read<SwipeBloc>().add(LoadUserEvent(
                              user: context.read<AuthBloc>().state.user!));
                        },
                        child: const Text(
                          "Back to Swiping",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Superior",
                              fontWeight: FontWeight.w800),
                        )),
                  ),
                ),
              ],
            ),
          );
        } else if (state is SwipeError) {
          return const Center(
              child: Text(
            "There are no more users",
            style: TextStyle(fontFamily: "Couture", fontSize: 15),
          ));
        } else {
          return const Text("Error");
        }
      },
    );
  }
}

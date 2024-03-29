import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/bloc/match/match_bloc.dart';
import 'package:amora/models/model.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/screens/chat/chat_screen.dart';
import 'package:amora/widget/user_like_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchScreen extends StatelessWidget {
  static const String routeName = "/match";

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => BlocProvider<MatchBloc>(
              create: (context) => MatchBloc(
                  databaseRepository: context.read<DatabaseRepository>(),
                  authBloc: context.read<AuthBloc>())
                ..add(LoadMatches(user: context.read<AuthBloc>().state.user!)),
              child: const MatchScreen(),
            ));
  }

  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MatchLoaded) {
          final inactiveMatches = state.matches
              .where((match) => match.chat.messages.length == 0)
              .toList();
          final activeMatches = state.matches
              .where((match) => match.chat.messages.length > 0)
              .toList();

          for (int i = 0; i < state.matches.length; i++) {
            print("UserId : ${state.matches[i].userId}");
            print("Mathced User : ${state.matches[i].matchedUser.name}");
            print("Chat : ${state.matches[i].chat.messages.length}");
          }
          // print(inactiveMatches);
          // for (int i = 0; i < inactiveMatches.length; i++) {
          //   print("UserId : ${inactiveMatches[i].userId}");
          //   print("Mathced User : ${inactiveMatches[i].matchedUser.name}");
          //   print("Chat : ${inactiveMatches[i].chat.messages.length}");
          // }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Likes",
                      style: TextStyle(fontFamily: 'Couture', fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    inactiveMatches.isEmpty
                        ? SizedBox(
                            height: 120,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                "assets/images/portrait.jpg",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                }),
                          )
                        : MatchList(inactiveMatches: inactiveMatches),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Your Chats",
                      style: TextStyle(fontFamily: 'Couture', fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ChatList(activeMatches: activeMatches)
                  ],
                ),
              ),
            ),
          );
        } else if (state is MatchUnavailable) {
          return const Center(
              child: Text(
            "No Macthes yet",
            style: TextStyle(fontFamily: "Couture", fontSize: 15),
          ));
        } else {
          return const Text("Error");
        }
      },
    );
  }
}

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.activeMatches,
  });

  final List<UserMatch> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: activeMatches.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.routeName,
                  arguments: activeMatches[index]);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Row(
                children: [
                  UserLikeCard(
                      url: activeMatches[index].matchedUser.imageUrls[0]['url'],
                      height: 70,
                      width: 70),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        activeMatches[index].matchedUser.name,
                        style: const TextStyle(
                            fontFamily: 'AbrilFatface', fontSize: 23),
                      ),
                      Text(
                        activeMatches[index].chat.messages[0].message,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w200),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class MatchList extends StatelessWidget {
  const MatchList({
    super.key,
    required this.inactiveMatches,
  });

  final List<UserMatch> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: inactiveMatches.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.routeName,
                    arguments: inactiveMatches[index]);
              },
              child: Column(
                children: [
                  UserLikeCard(
                    url: inactiveMatches[index].matchedUser.imageUrls[0]['url'],
                    height: 90,
                    width: 90,
                  ),
                  Center(
                      child: Text(
                    inactiveMatches[index].matchedUser.name,
                    style: const TextStyle(
                        fontFamily: "AbrilFatFace", fontSize: 15),
                  ))
                ],
              ),
            );
          }),
    );
  }
}

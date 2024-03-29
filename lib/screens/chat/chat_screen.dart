// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:amora/bloc/auth/auth_bloc.dart';
import 'package:amora/bloc/chat/chat_bloc.dart';
import 'package:amora/models/model.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ChatBloc>(
        create: (context) =>
            ChatBloc(databaseRepository: context.read<DatabaseRepository>())
              ..add(LoadChat(chatId: userMatch.chat.id)),
        child: ChatScreen(userMatch: userMatch),
      ),
    );
  }

  final UserMatch userMatch;
  const ChatScreen({super.key, required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 63, 63, 63)),
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 30,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(userMatch.matchedUser.imageUrls[0]['url']),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                userMatch.matchedUser.name,
                style: const TextStyle(
                    fontFamily: 'CarterOne',
                    fontSize: 25,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ChatLoaded) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    // ignore: unnecessary_null_comparison
                    child: userMatch.chat != null
                        ? ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: state.chat.messages.length,
                            itemBuilder: (context, index) {
                              List<Message> msgs = state.chat.messages;
                              return ListTile(
                                title: _Message(
                                  message: msgs[index].message,
                                  isFromCurrUser: msgs[index].senderId ==
                                      context
                                          .read<AuthBloc>()
                                          .state
                                          .authUser!
                                          .uid,
                                ),
                              );
                            })
                        : const SizedBox(),
                  ),
                ),
                _TypeMessage(userMatch: userMatch)
              ],
            );
          } else {
            return const Text("Something Went Wrong");
          }
        },
      ),
    );
  }
}

class _TypeMessage extends StatelessWidget {
  final UserMatch userMatch;
  const _TypeMessage({
    required this.userMatch,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _msgController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.read<ChatBloc>()
                  ..add(AddMessage(
                      macthedUserId: userMatch.matchedUser.id,
                      message: _msgController.text,
                      userId: userMatch.userId));
                _msgController.clear();
              },
              icon: const Icon(Ionicons.send)),
          Expanded(
            child: TextField(
              controller: _msgController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Type here...',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  contentPadding:
                      EdgeInsets.only(left: 20, top: 10, bottom: 10)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final String message;
  final bool isFromCurrUser;
  const _Message({
    required this.message,
    required this.isFromCurrUser,
  });

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry align =
        isFromCurrUser ? Alignment.topRight : Alignment.topLeft;

    Color color = isFromCurrUser
        ? Colors.amber
        : const Color.fromARGB(255, 245, 220, 176);
    return Align(
      alignment: align,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(message),
      ),
    );
  }
}

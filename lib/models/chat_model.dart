import 'message_model.dart';

class Chat {
  final String id;
  final List<String> userIds;
  final List<Message> messages;

  Chat({required this.id, required this.userIds, required this.messages});

  factory Chat.fromJson(Map<String, dynamic> json, {String? id}) {
    List<Message> msgs = (json['messages'] as List)
        .map((message) => Message.fromJson(message))
        .toList();

    msgs.sort(((a, b) {
      return b.dateTime.compareTo(a.dateTime);
    }));
    return Chat(
        id: id ?? json['id'],
        userIds: (json['userIds'] as List)
            .map((userId) => userId as String)
            .toList(),
        messages: msgs);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userIds': userIds, 'messages': messages};
  }

  List<Object?> get props => [id, userIds, messages];

  // static List<Chat> chats = [
  //   Chat(
  //     id: 1,
  //     userId: 1,
  //     matchedUserId: 2,
  //     messages: Message.messages
  //         .where((message) =>
  //             (message.senderId == 1 && message.receiverId == 2) ||
  //             (message.senderId == 2 && message.receiverId == 1))
  //         .toList(),
  //   ),
  //   Chat(
  //     id: 2,
  //     userId: 1,
  //     matchedUserId: 3,
  //     messages: Message.messages
  //         .where((message) =>
  //             (message.senderId == 1 && message.receiverId == 3) ||
  //             (message.senderId == 3 && message.receiverId == 1))
  //         .toList(),
  //   ),
  //   Chat(
  //     id: 3,
  //     userId: 1,
  //     matchedUserId: 5,
  //     messages: Message.messages
  //         .where((message) =>
  //             (message.senderId == 1 && message.receiverId == 5) ||
  //             (message.senderId == 5 && message.receiverId == 1))
  //         .toList(),
  //   ),
  //   Chat(
  //     id: 4,
  //     userId: 1,
  //     matchedUserId: 6,
  //     messages: Message.messages
  //         .where((message) =>
  //             (message.senderId == 1 && message.receiverId == 6) ||
  //             (message.senderId == 6 && message.receiverId == 1))
  //         .toList(),
  //   ),
  // ];
}

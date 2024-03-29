part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChat extends ChatEvent {
  final String? chatId;

  const LoadChat({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}

class UpdateChat extends ChatEvent {
  final Chat chat;

  const UpdateChat({required this.chat});

  @override
  List<Object> get props => [chat];
}

class AddMessage extends ChatEvent {
  final String userId;
  final String macthedUserId;
  final String message;

  const AddMessage({required this.macthedUserId,required this.message, required this.userId});

  @override
  List<Object> get props => [userId, macthedUserId, message];
}

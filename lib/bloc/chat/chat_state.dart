part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final Chat chat;

  const ChatLoaded({required this.chat});

  @override
  List<Object> get props => [chat];
}

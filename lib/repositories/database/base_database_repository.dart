import 'package:amora/models/model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  Stream<List<User>> getUserToSwipe(User user);
  Stream<Chat> getChat(String chatId);
  Future<String> checkUser(String userId);
  Stream<List<User>> getUsers(User user);
  Stream<List<UserMatch>> getMatch(User user);
  Stream<List<Chat>> getChats(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> updateUserPicture(User user, String imgName);
  Future<void> deleteUserPicture(User user, Map<String, dynamic> img);
  Future<String> getImageName(User user, String url);
  Future<void> updateUserSwipe(
      String userId, String matchId, bool isSwipeRight);
  Future<void> updateUserMatch(String userId, String matchId);
  Future<void> updateUserInterest(User user, String interest, bool add);
  Future<void> addMessage(String chatId, Message message);
}

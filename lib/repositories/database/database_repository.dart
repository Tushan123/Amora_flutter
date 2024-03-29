import 'package:amora/models/model.dart';
import 'package:amora/repositories/database/base_database_repository.dart';
import 'package:amora/repositories/storage/storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection('user')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> addMessage(String chatId, Message message) {
    return _firebaseFirestore.collection('chat').doc(chatId).update({
      'messages': FieldValue.arrayUnion([
        Message(
                senderId: message.senderId,
                receiverId: message.receiverId,
                message: message.message,
                dateTime: message.dateTime,
                timeString: message.timeString)
            .toJson()
      ])
    });
  }

  @override
  Stream<Chat> getChat(String chatId) {
    return _firebaseFirestore.collection('chat').doc(chatId).snapshots().map(
        (doc) => Chat.fromJson(doc.data() as Map<String, dynamic>, id: doc.id));
  }

  @override
  Stream<List<Chat>> getChats(String userId) {
    return _firebaseFirestore
        .collection('chat')
        .where('userIds', arrayContains: userId)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => Chat.fromJson(doc.data(), id: doc.id))
          .toList();
    });
  }

  @override
  Stream<List<User>> getUsers(User user) {
    print("Get Users ${user.genderPrefered}");
    return _firebaseFirestore
        .collection('user')
        .where('gender', whereIn: _selectGender(user))
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        String documentId = doc.id;
        print('Document ID: $documentId');
        return User.fromSnapshot(doc);
      }).toList();
    });
  }

  @override
  Stream<List<UserMatch>> getMatch(User user) {
    return Rx.combineLatest3(
        getUser(user.id), getChats(user.id), getUsers(user),
        (User user, List<Chat> userChats, List<User> users) {
      return users.where((otherUser) {
        List<String> matches =
            user.matches!.map((match) => match['matchId'] as String).toList();
        return matches.contains(otherUser.id);
      }).map((matchUser) {
        Chat chat = userChats.where((chat) {
          return chat.userIds.contains(matchUser.id) &
              chat.userIds.contains(user.id);
        }).first;

        return UserMatch(userId: user.id, matchedUser: matchUser, chat: chat);
      }).toList();
    });
  }

  @override
  Future<void> updateUserSwipe(
      String userId, String matchId, bool isSwipeRight) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('user').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('user').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(String userId, String matchId) async {
    String chatId = await _firebaseFirestore.collection('chat').add({
      'userIds': [userId, matchId],
      'messages': [],
    }).then((value) => value.id);

    await _firebaseFirestore.collection('user').doc(userId).update({
      'matches': FieldValue.arrayUnion([
        {'matchId': matchId, 'chatId': chatId}
      ])
    });

    await _firebaseFirestore.collection('user').doc(matchId).update({
      'matches': FieldValue.arrayUnion([
        {'matchId': userId, 'chatId': chatId}
      ])
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('user').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) {
    return _firebaseFirestore
        .collection("user")
        .doc(user.id)
        .update(user.toMap())
        .then((value) {
      //  print("User Updated");
    });
  }

  @override
  Future<void> updateUserPicture(User user, String imgName) async {
    String downloadUrl =
        await StorageRepository().getDownloadUrl(user, imgName);

    return _firebaseFirestore.collection('user').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([
        {'url': downloadUrl, 'image': imgName}
      ])
    });
  }

  @override
  Future<void> updateUserInterest(User user, String interest, bool add) {
    if (add) {
      return _firebaseFirestore.collection('user').doc(user.id).update({
        'interests': FieldValue.arrayUnion([interest])
      });
    } else {
      return _firebaseFirestore.collection('user').doc(user.id).update({
        'interests': FieldValue.arrayRemove([interest])
      });
    }
  }

  @override
  Future<String> checkUser(String userId) async {
    final snap = await _firebaseFirestore.collection('user').doc(userId).get();
    if (snap.exists) {
      final data = snap.data() as Map<String, dynamic>;
      return data['id'];
    }
    return "";
  }

  @override
  Stream<List<User>> getUserToSwipe(User user) {
    return Rx.combineLatest2(getUser(user.id), getUsers(user),
        (User currentUser, List<User> users) {
      //    print("getUserToSwipe : ${users}");
      return users.where((user) {
        bool isCurrUser = user.id == currentUser.id;
        bool wasLeftSwipe = currentUser.swipeLeft!.contains(user.id);
        bool wasRightSwipe = currentUser.swipeRight!.contains(user.id);
        bool isMatch = currentUser.matches!.contains(user.id);

        bool isInAgeRange = user.age >= currentUser.agePrefered![0] &&
            user.age <= currentUser.agePrefered![1];
        if (isCurrUser) {
          return false;
        }
        if (wasLeftSwipe) {
          return false;
        }
        if (wasRightSwipe) {
          return false;
        }
        if (isMatch) {
          return false;
        }
        if (!isInAgeRange) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  _selectGender(User user) {
    if (user.genderPrefered == null) {
      return ['Male', 'Female', 'Non-binary'];
    }
    return user.genderPrefered;
  }

  @override
  Future<void> deleteUserPicture(User user, Map<String, dynamic> img) async {
    await _firebaseFirestore.collection('user').doc(user.id).update({
      'imageUrls': FieldValue.arrayRemove([img]),
    });
  }

  @override
  Future<String> getImageName(User user, String url) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection('user')
        .where('url', isEqualTo: url)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['image'];
    } else {
      return "";
    }
  }
}

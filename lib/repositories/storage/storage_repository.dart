import 'dart:io';

import 'package:amora/repositories/database/database_repository.dart';
import 'package:amora/repositories/storage/base_storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';

class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(User user, XFile image) async {
    try {
      await storage
          .ref('user/${user.id}/${image.name}')
          .putFile(File(image.path))
          .then(
              (p0) => DatabaseRepository().updateUserPicture(user, image.name));
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(User user, String imgName) async {
    String url = await storage.ref('user/${user.id}/$imgName').getDownloadURL();

    return url;
  }

  @override
  Future<void> deleteImage(User user, Map<String, dynamic> img) async {
    print("Image Deleted");

    await storage
        .ref()
        .child("user/${user.id}/${img['image']}")
        .delete()
        .then((value) => DatabaseRepository().deleteUserPicture(user, img));
  }
}

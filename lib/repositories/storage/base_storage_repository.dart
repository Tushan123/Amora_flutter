import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';

abstract class BaseStorageRepository {
  Future<void> uploadImage(User user, XFile image);
  Future<void> deleteImage(User user, Map<String, dynamic> img);
  Future<String> getDownloadUrl(User user, String imgName);
}

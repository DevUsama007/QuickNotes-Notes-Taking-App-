import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}

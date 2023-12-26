import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGallery() async {
  XFile? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = pickedImage;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}

import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  final pickedImage = await Get.find<ImagePicker>().pickImage(
    source: ImageSource.gallery,
  );
  if (pickedImage == null) return null;
  return File(pickedImage.path);
}

Future<File?> pickImageFromCamera() async {
  final pickedImage = await Get.find<ImagePicker>().pickImage(
    source: ImageSource.camera,
    imageQuality: 50,
  );
  if (pickedImage == null) return null;
  return File(pickedImage.path);
}

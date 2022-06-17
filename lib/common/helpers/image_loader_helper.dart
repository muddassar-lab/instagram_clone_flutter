import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

Future<File?> loadImage(AssetEntity photo) async {
  return await photo.file;
}

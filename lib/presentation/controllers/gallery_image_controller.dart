import 'dart:io';

import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryImageController extends GetxController {
  final Rx<List<File>> _photos = Rx<List<File>>([]);
  final Rx<File?> _selectedPhoto = Rx<File?>(null);
  final Rx<AssetPathEntity?> _selectedAlbum = Rx<AssetPathEntity?>(null);
  final Rx<List<AssetPathEntity>> _albums = Rx<List<AssetPathEntity>>([]);
  final Rx<bool> _loading = Rx<bool>(false);
  final Rx<int> _end = Rx<int>(30);

  Future<void> loadMoreImages() async {
    _loading.value = true;
    final int start = _end.value;
    _end.value += 30;
    await _loadPhotos(start: start, end: _end.value, replace: false);
    _photos.refresh();

    _loading.value = false;
  }

  void selectPhoto(File photo) {
    _selectedPhoto.value = photo;
  }

  Future<void> loadAlbumsAndPhotos() async {
    _loading.value = true;
    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);
    _albums.value = albums;
    _selectedAlbum.value = albums.first;
    await _loadPhotos(start: 0, end: _end.value, replace: true);
    _loading.value = false;
  }

  Future<List<File>> _loadPhotos({
    required int start,
    required int end,
    required bool replace,
  }) async {
    final List<File> tempPhotos = [];
    final photosFromGallery = await _selectedAlbum.value!.getAssetListRange(
      start: start,
      end: end,
    );
    for (final photo in photosFromGallery) {
      final file = await photo.file;
      if (file != null) {
        tempPhotos.add(file);
      }
    }
    if (replace) {
      _photos.value = tempPhotos;
      _selectedPhoto.value = tempPhotos.first;
    } else {
      _photos.value.addAll(tempPhotos);
    }
    return tempPhotos;
  }

  Future<void> changeAlbum(AssetPathEntity album) async {
    await PhotoManager.clearFileCache();
    _loading.value = true;
    _selectedAlbum.value = album;

    await _loadPhotos(start: 0, end: _end.value, replace: true);

    _loading.value = false;
  }

  //getters
  List<File> get photos => _photos.value;
  List<AssetPathEntity> get albums => _albums.value;
  File? get selectedPhoto => _selectedPhoto.value;
  AssetPathEntity? get selectedAlbum => _selectedAlbum.value;
  bool get loading => _loading.value;

  //Listeners

}

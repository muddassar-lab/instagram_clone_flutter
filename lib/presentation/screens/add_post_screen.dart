import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/common/helpers/image_picker_helper.dart';
import 'package:instagram_clone_flutter/presentation/controllers/gallery_image_controller.dart';
import 'package:instagram_clone_flutter/presentation/screens/save_post_screen.dart';
import 'package:instagram_clone_flutter/presentation/widgets/gallery_image_thumbnail.dart';
import 'package:logger/logger.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostScreen extends StatefulWidget {
  static const String routeName = '/add_post';
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ScrollController _scrollController = ScrollController();
  final GalleryImageController galleryImageController = Get.find();

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      galleryImageController.loadMoreImages();
    }
  }

  Future<void> requestPermission() async {
    await PhotoManager.requestPermissionExtend();
  }

  @override
  void initState() {
    super.initState();
    galleryImageController.loadAlbumsAndPhotos();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    galleryImageController.clear();
    print("Cleared gallery image controller values");
  }

  Future<void> _pickImage() async {
    try {
      final pickedImage = await pickImageFromCamera();
      if (pickedImage == null) return;
      galleryImageController.selectPhoto(pickedImage);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Add Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 30,
              color: Colors.black,
            ),
            onPressed: galleryImageController.selectedPhoto != null
                ? () => Get.toNamed(
                      SavePostScreen.routeName,
                    )
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: galleryImageController.selectedPhoto == null
                  ? const Center(
                      child: Text("No photo selected"),
                    )
                  : Image.file(
                      galleryImageController.selectedPhoto!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<AssetPathEntity>(
                        isExpanded: true,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        value: galleryImageController.selectedAlbum,
                        onChanged: (AssetPathEntity? album) =>
                            galleryImageController.changeAlbum(album!),
                        items: galleryImageController.albums.map(
                          (AssetPathEntity album) {
                            return DropdownMenuItem<AssetPathEntity>(
                              value: album,
                              child: Text(album.name),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Expanded(
              child: GridView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: galleryImageController.photos.length,
                itemBuilder: (context, index) {
                  final photo = galleryImageController.photos[index];
                  return GalleryImageThumbnail(
                    photo: photo,
                    onSelectPhoto: () => galleryImageController.selectPhoto(
                      photo,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

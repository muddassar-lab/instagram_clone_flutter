import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/presentation/controllers/gallery_image_controller.dart';
import 'package:instagram_clone_flutter/presentation/controllers/posts_controller.dart';
import 'package:instagram_clone_flutter/presentation/widgets/custom_button.dart';

class SavePostScreen extends StatefulWidget {
  static const String routeName = '/save_post';
  const SavePostScreen({Key? key}) : super(key: key);

  @override
  State<SavePostScreen> createState() => _SavePostScreenState();
}

class _SavePostScreenState extends State<SavePostScreen> {
  final PostsController postsController = Get.find();
  final TextEditingController controller = TextEditingController();
  final GalleryImageController galleryImageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Image.file(
                  galleryImageController.selectedPhoto!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Caption.......",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
              () => CustomButton(
                text: "Save",
                isLoading: postsController.loading,
                onPressed: postsController.loading
                    ? null
                    : () => postsController.addPost(
                          title: controller.text,
                          image: galleryImageController.selectedPhoto!,
                        ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

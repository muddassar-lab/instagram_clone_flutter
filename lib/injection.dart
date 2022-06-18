import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/data/repositories/auth_repository_implementation.dart';
import 'package:instagram_clone_flutter/data/repositories/posts_repository_implementation.dart';
import 'package:instagram_clone_flutter/domain/repositories/auth_repository.dart';
import 'package:instagram_clone_flutter/domain/repositories/post_repository.dart';
import 'package:instagram_clone_flutter/presentation/controllers/auth_controller.dart';
import 'package:instagram_clone_flutter/presentation/controllers/gallery_image_controller.dart';
import 'package:instagram_clone_flutter/presentation/controllers/posts_controller.dart';
import 'package:logger/logger.dart';

class Inject {
  static Future<void> inject() async {
    //Third party libraries are initialized here.
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseStorage storage = FirebaseStorage.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Logger logger = Logger();
    Get.lazyPut<FirebaseAuth>(() => auth);
    Get.lazyPut<FirebaseStorage>(() => storage);
    Get.lazyPut<Logger>(() => logger);
    Get.put<ImagePicker>(ImagePicker());
    Get.lazyPut(() => firestore);

    //Repositories are initialized here.
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImplementation(
        auth: Get.find(),
        storage: Get.find(),
      ),
    );
    Get.lazyPut<PostRepository>(
      () => PostsRepositoryImplementation(
        auth: Get.find(),
        storage: Get.find(),
        firestore: Get.find(),
      ),
    );

    //Controllers are initialized here.
    Get.put(
      AuthController(
        auth: Get.find(),
        logger: Get.find(),
      ),
    );
    Get.lazyPut(() => GalleryImageController());
    Get.lazyPut(
      () => PostsController(
        postRepository: Get.find(),
      ),
    );
  }
}

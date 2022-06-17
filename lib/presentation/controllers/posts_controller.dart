import 'dart:io';

import 'package:get/get.dart';
import 'package:instagram_clone_flutter/domain/repositories/post_repository.dart';
import 'package:instagram_clone_flutter/models/post.dart';
import 'package:instagram_clone_flutter/presentation/screens/home_screen.dart';

class PostsController extends GetxController {
  final PostRepository postRepository;
  final Rx<bool> _loading = false.obs;
  final Rx<List<Post>> _posts = Rx<List<Post>>([]);
  PostsController({required this.postRepository});

  Future<void> addPost({required String title, required File image}) async {
    _loading.value = true;
    await postRepository.addPost(title: title, image: image);
    _loading.value = false;
    Get.offAllNamed(HomeScreen.routeName);
  }

  //setters

  //getters
  bool get loading => _loading.value;
  List<Post> get posts => _posts.value;
}

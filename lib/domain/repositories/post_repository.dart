import 'dart:io';

abstract class PostRepository {
  Future<void> addPost({
    required String title,
    required File image,
  });
}

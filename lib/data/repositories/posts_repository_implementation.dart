import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone_flutter/domain/repositories/auth_repository.dart';
import 'package:instagram_clone_flutter/domain/repositories/post_repository.dart';

class PostsRepositoryImplementation implements PostRepository {
  final AuthRepository auth;
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;
  PostsRepositoryImplementation({
    required this.auth,
    required this.storage,
    required this.firestore,
  });
  @override
  Future<void> addPost({
    required String title,
    required File image,
  }) async {
    final User? user = auth.getCurrentUser();
    if (user == null) {
      return;
    }
    final imageName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    final reference = storage.ref().child('posts').child(imageName);
    final String? downloadUrl = await auth.uploadImageToFirebase(
      file: image,
      reference: reference,
    );
    if (downloadUrl == null) {
      return;
    }
    final post = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'title': title,
      'imageUrl': downloadUrl,
      'uid': user.uid,
      'userProfileImage': user.photoURL,
    };
    await firestore.collection('posts').add(post);
  }
}

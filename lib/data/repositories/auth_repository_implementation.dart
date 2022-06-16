import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone_flutter/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  AuthRepositoryImplementation({required this.auth, required this.storage});
  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<User?> onAuthStateChanged() {
    return auth.authStateChanges();
  }

  Future<String> _uploadImageToFirebase({
    required File file,
    required Reference reference,
  }) async {
    final TaskSnapshot uploadTask = await reference.putFile(file);
    final String downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required File profileImageFile,
  }) async {
    try {
      final imageName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final reference = storage.ref().child('users').child(imageName);
      final String downloadUrl = await _uploadImageToFirebase(
        file: profileImageFile,
        reference: reference,
      );
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.updatePhotoURL(downloadUrl);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

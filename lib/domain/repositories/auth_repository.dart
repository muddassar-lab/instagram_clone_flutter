import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required File profileImageFile,
  });
  User? getCurrentUser();
  Future<void> logout();
  Future<String?> uploadImageToFirebase({
    required File file,
    required Reference reference,
  });
  Stream<User?> onAuthStateChanged();
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required File profileImageFile,
  });
  Future<void> logout();
  Stream<User?> onAuthStateChanged();
}

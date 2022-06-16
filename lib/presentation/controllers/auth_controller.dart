import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/domain/repositories/auth_repository.dart';
import 'package:instagram_clone_flutter/presentation/screens/home_screen.dart';
import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  final AuthRepository auth;
  final Logger logger;
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<bool> _loading = false.obs;
  //Constructor
  AuthController({
    required this.auth,
    required this.logger,
  });
  //Controller Super methods
  @override
  void onReady() {
    super.onReady();

    _listenToAuthChanges();
  }

  //methods
  Future<void> login({
    required String email,
    required String password,
  }) async {
    _loading.value = true;
    await auth.login(email: email, password: password);
    _loading.value = false;
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required File profileImageFile,
  }) async {
    _loading.value = true;
    await auth.register(
      email: email,
      password: password,
      name: name,
      profileImageFile: profileImageFile,
    );
    _loading.value = false;
  }

  Future<void> logout() async {
    _loading.value = true;
    await auth.logout();
    _loading.value = false;
  }

  //getters
  User? get user => _user.value;
  bool get loading => _loading.value;

  //Listeners
  void _listenToAuthChanges() {
    auth.onAuthStateChanged().listen((user) {
      if (user != null) {
        logger.i("User logged in: $user");
        _user.value = user;
        Get.offAllNamed(HomeScreen.routeName);
      } else {
        logger.i("User logged out");
        _user.value = null;
        Get.offAllNamed(LoginScreen.routeName);
      }
    });
  }
}

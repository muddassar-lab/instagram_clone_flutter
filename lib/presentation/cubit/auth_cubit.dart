import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:instagram_clone_flutter/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository auth;
  AuthCubit({required this.auth}) : super(AuthInitial()) {
    _authStateListener();
  }
  //Auth Methods
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    await auth.login(email: email, password: password);
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required File profileImageFile,
  }) async {
    emit(AuthLoading());
    await auth.register(
      email: email,
      password: password,
      name: name,
      profileImageFile: profileImageFile,
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await auth.logout();
  }

  // Listen to auth state changes
  _authStateListener() {
    auth.onAuthStateChanged().listen((User? user) {
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}

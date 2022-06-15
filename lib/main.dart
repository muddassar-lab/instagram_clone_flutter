import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/app/app.dart';
import 'package:instagram_clone_flutter/firebase_options.dart';
import 'package:instagram_clone_flutter/injection.dart';
import 'package:instagram_clone_flutter/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Inject.inject();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(
      create: (context) => Get.find(),
    ),
  ], child: const App()));
}

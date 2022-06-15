import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/data/repositories/auth_repository_implementation.dart';
import 'package:instagram_clone_flutter/domain/repositories/auth_repository.dart';
import 'package:instagram_clone_flutter/presentation/cubit/auth_cubit.dart';

class Inject {
  static void inject() async {
    //Third party libraries are initialized here.
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseStorage storage = FirebaseStorage.instance;
    Get.lazyPut<FirebaseAuth>(() => auth);
    Get.lazyPut<FirebaseStorage>(() => storage);

    //Repositories are initialized here.
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImplementation(
        auth: Get.find(),
        storage: Get.find(),
      ),
    );

    //Cubits are initialized here.
    Get.lazyPut<AuthCubit>(
      () => AuthCubit(
        auth: Get.find(),
      ),
    );
  }
}

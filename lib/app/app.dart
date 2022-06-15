import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';
import 'package:instagram_clone_flutter/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram",
      onGenerateRoute: CustomRouter.onGenerateRoute,
      home: LoginScreen(),
    );
  }
}

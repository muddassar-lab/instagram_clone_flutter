import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:instagram_clone_flutter/presentation/screens/home_screen.dart';
import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';
import 'package:instagram_clone_flutter/presentation/screens/splash_screen.dart';
import 'package:instagram_clone_flutter/router.dart';

class App extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Instagram",
      navigatorKey: _navigatorKey,
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}

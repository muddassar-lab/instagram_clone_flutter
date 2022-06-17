import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hexcolor/hexcolor.dart';
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: HexColor("#FAFAFA"),
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: HexColor("#FAFAFA"),
        ),
      ),
      navigatorKey: _navigatorKey,
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/screens/login_screen.dart';
import 'package:instagram_clone_flutter/presentation/screens/register_screen.dart';

class CustomRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return pageBuilder(const LoginScreen());
      case RegisterScreen.routeName:
        return pageBuilder(const RegisterScreen());
      default:
        return pageBuilder(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute pageBuilder(Widget child) {
    return MaterialPageRoute(
      builder: (_) => child,
    );
  }
}
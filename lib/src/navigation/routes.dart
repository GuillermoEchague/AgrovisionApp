import 'package:agrovision/src/ui/email_create_screen.dart';
import 'package:agrovision/src/ui/email_signin_screen.dart';
import 'package:agrovision/src/ui/home_screen.dart';
import 'package:agrovision/src/ui/intro_screen.dart';
import 'package:agrovision/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);
      case createAccount:
        return _buildRoute(EmailCreate.create);
      case signInEmail:
        return _buildRoute(EmailSignIn.create);
      default:
        throw Exception('Route does not exits');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}

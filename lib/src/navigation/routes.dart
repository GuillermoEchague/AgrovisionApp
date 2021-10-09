import 'package:agrovision/src/ui/home_screen.dart';
import 'package:agrovision/src/ui/intro_screen.dart';
import 'package:agrovision/src/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';

  static Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(IntroScreen.create);
      case home:
        return _buildRoute(HomeScreen.create);

      default:
        throw Exception('Route does not exits');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}

import 'package:agrovision/src/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation/routes.dart';

final _navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigationKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.intro, (route) => false);
        } else if (state is AuthSignedIn) {
          _navigationKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.home, (route) => false);
        }
      },
      child: MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      onGenerateRoute: Routes.routes,
    );
  }
}

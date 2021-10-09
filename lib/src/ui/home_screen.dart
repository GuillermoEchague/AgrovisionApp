import 'package:agrovision/src/bloc/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static Widget create(BuildContext context) => HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is AuthSignedIn,
          builder: (_, state) {
            final authUser = (state as AuthSignedIn).user;
            return Center(
              child: Column(
                children: [
                  Text('User: ${authUser.uid}'),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().signOut(),
                    child: Text("Logout"),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

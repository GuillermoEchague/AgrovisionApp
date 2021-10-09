import 'package:agrovision/src/bloc/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:page_indicator/page_indicator.dart';

class IntroScreen extends StatelessWidget {
  static Widget create(BuildContext context) => IntroScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _IntroPager(),
    );
  }
}

class _IntroPager extends HookWidget {
  final String exampleText1 =
      'Desarrollo de un analizador de enfermedades de plantas en tiempo real, para determinar la mejor estrategica a su problema';
  final String exampleText2 =
      'Solución desarrollada de manera multiplataforma, todo almacenado en la nube';

  @override
  Widget build(BuildContext context) {
    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;
    return AbsorbPointer(
      absorbing: isSigningIn,
      child: PageIndicatorContainer(
        child: PageView(
          children: [
            _DescriptionPage(
              text: exampleText1,
              imagePath: 'assets/intro_2.png',
            ),
            _DescriptionPage(
              text: exampleText2,
              imagePath: 'assets/intro_3.png',
            ),
            _LoginPage(),
          ],
        ),
        length: 3,
        align: IndicatorAlign.bottom,
        indicatorSpace: 15,
      ),
    );
  }
}

class _DescriptionPage extends StatelessWidget {
  final String text;
  final String imagePath;

  const _DescriptionPage({
    Key? key,
    required this.text,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isSigningIn = context.watch<AuthCubit>().state is AuthSigningIn;
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Image.asset(
            'assets/intro_2.png',
            width: 200,
            height: 200,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Sign in or create an account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (isSigningIn) CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 45,
            ),
            child: Column(
              children: [
                _LoginButton(
                  text: 'Sign in with Google',
                  imagePath: 'assets/icon_google.png',
                  color: Colors.white,
                  textColor: Colors.grey,
                  onTap: () => context.read<AuthCubit>().signInWithGoogle(),
                ),
                SizedBox(
                  height: 8,
                ),
                _LoginButton(
                  text: 'Sign in with Facebook',
                  imagePath: 'assets/icon_facebook.png',
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onTap: () {
                    //TODO
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                _LoginButton(
                  text: 'Sign in with Email',
                  imagePath: 'assets/icon_email.png',
                  color: Colors.red,
                  textColor: Colors.white,
                  onTap: () {
                    //TODO
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                _LoginButton(
                  text: 'Sign in with anonymously',
                  imagePath: 'assets/icon_question.png',
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  onTap: () => context.read<AuthCubit>().signInAnonymously(),
                ),
                SizedBox(
                  height: 50,
                ),
                OutlinedButton(
                  child: Text('Create account'),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  const _LoginButton({
    Key? key,
    required this.text,
    required this.imagePath,
    this.onTap,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 3,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

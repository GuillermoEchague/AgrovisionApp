import 'package:agrovision/src/bloc/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailCreate extends StatefulWidget {
  static Widget create(BuildContext context) => EmailCreate();

  @override
  State<StatefulWidget> createState() => _EmailCreateState();
}

class _EmailCreateState extends State<EmailCreate> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  String? emailValidator(String? value) {
    return (value == null || value.isEmpty) ? 'This is a required field' : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'This is a required field';
    if (value.length < 6) return 'Password should be at least 6 letters';
    if (_passwordController.text != _repeatPasswordController.text)
      return 'Password do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create account'),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (_, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is AuthSigningIn)
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is AuthError)
                      Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: emailValidator,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: passwordValidator,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _repeatPasswordController,
                      decoration: InputDecoration(labelText: 'Repeat Password'),
                      validator: passwordValidator,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context
                                .read<AuthCubit>()
                                .createUserWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);
                          }
                        },
                        child: Text('Create'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:group_gps_chat_app/src/actions/index.dart';
import 'package:group_gps_chat_app/src/models/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onResponse(dynamic action) {

    if(action is CreateUserError){
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message??error.code)));
      }
    } else if (action is LoginError) {
      final Object error = action.error;
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message??error.code)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'email',
                  ),
                  validator: (String? value) {
                    if (value == null || !value.contains('@')) {
                      return 'Not a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'password',
                  ),
                  validator: (String? value) {
                    if (value == null || value.length < 6) {
                      return 'Password must contain at least 6 characters';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                Builder(
                  builder: (BuildContext context) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: const Text('login'),
                            onPressed: () {
                              if (!Form.of(context).validate()) {
                                return;
                              } else {
                                final Login action =
                                    Login(email: _emailController.text, password: _passwordController.text, response: _onResponse);
                                StoreProvider.of<AppState>(context).dispatch(action);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            child: const Text('Create account'),
                            onPressed: () {
                              if (!Form.of(context).validate()) {
                                return;
                              } else {
                                final CreateUser action =
                                    CreateUser(email: _emailController.text, password: _passwordController.text, response: _onResponse);
                                StoreProvider.of<AppState>(context).dispatch(action);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
    
  }


}

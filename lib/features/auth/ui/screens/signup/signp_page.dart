import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/app/notifiers/auth_notifier.dart';
import 'package:todo_flutter/core/utils/view_state.dart';
import 'package:todo_flutter/di/service_locator.dart';
import 'package:todo_flutter/features/auth/ui/notifiers/signup_notifier.dart';

class SignpPage extends StatefulWidget {
  const SignpPage({super.key});

  @override
  State<SignpPage> createState() => _SignpPageState();
}

class _SignpPageState extends State<SignpPage> {
  final SignupNotifier _signupNotifier = serviceLocator<SignupNotifier>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  

  void signUp() {
    if (_formKey.currentState!.validate()) {
      // Perform sign up logic here

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signing up...')));

      _signupNotifier.signUp(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      // Clear the form fields after sign up
      _usernameController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewState = _signupNotifier.state;

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
        key: _formKey,
        child: _signupNotifier.state == ViewState.loading ? 
        CircularProgressIndicator(
          
        )
        :  FocusTraversalGroup(
          policy: OrderedTraversalPolicy(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  controller: _passwordController,
                  obscureText: _obscureText,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle sign up logic

                  if (_formKey.currentState!.validate()) {
                    // Perform sign up

                    signUp();
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

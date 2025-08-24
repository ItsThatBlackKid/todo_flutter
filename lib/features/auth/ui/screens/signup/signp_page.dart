import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/app/notifiers/auth_notifier.dart';
import 'package:todo_flutter/core/utils/view_state.dart';

class SignpPage extends StatefulWidget {
  const SignpPage({super.key});

  @override
  State<SignpPage> createState() => _SignpPageState();
}

class _SignpPageState extends State<SignpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Perform sign up logic here
      final AuthNotifier notifier = context.read<AuthNotifier>();
      final messenger = ScaffoldMessenger.of(context);
      final router = GoRouter.of(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signing up...')));

      var success = await notifier.signUp(
        _usernameController.text,
        _passwordController.text,
      );

      if (mounted && success) {
        router.goNamed('home');
      } else if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(notifier.errorMsg),
            backgroundColor: Colors.red,
          ),
        );
      }

      // Clear the form fields after sign up
      _usernameController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var viewState = context.select((AuthNotifier n) => n.state);

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
        key: _formKey,
        child: viewState == ViewState.loading
            ? CircularProgressIndicator()
            : FocusTraversalGroup(
                policy: OrderedTraversalPolicy(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
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
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                          signUp(context);
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

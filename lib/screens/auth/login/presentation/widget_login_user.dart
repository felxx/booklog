import 'package:flutter/material.dart';
import 'package:booklog/config/routes.dart';
import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/core/utils/validation_utils.dart';

class WidgetLoginUser extends StatefulWidget {
  const WidgetLoginUser({super.key});

  @override
  _WidgetLoginUserState createState() => _WidgetLoginUserState();
}

class _WidgetLoginUserState extends State<WidgetLoginUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      // Additional email validation
      if (!ValidationUtils.isValidEmail(_emailController.text.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email address.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _authService.signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text,
        );

        if (response != null && response.user != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login successful!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid email or password.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          String errorMessage = 'Login error: ${e.toString()}';
          
          // Friendly error messages
          if (e.toString().contains('email_address_invalid')) {
            errorMessage = 'Please enter a valid email address.';
          } else if (e.toString().contains('invalid_login_credentials')) {
            errorMessage = 'Invalid email or password.';
          } else if (e.toString().contains('invalid_email')) {
            errorMessage = 'Invalid email format.';
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 100),
              Text(
                'Welcome back to Booklog!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return ValidationUtils.getEmailErrorMessage(value ?? '');
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  return ValidationUtils.getPasswordErrorMessage(value ?? '');
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _isLoading ? null : _performLogin,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.amber)
                  : const Text('Login'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Functionality coming soon!')),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.amber,
                ),
                child: const Text('Forgot the password?'),
              ),
              const SizedBox(height: 0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.registerUser);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.amber,
                ),
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
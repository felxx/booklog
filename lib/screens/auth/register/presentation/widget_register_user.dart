import 'package:booklog/config/routes.dart';
import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/core/utils/validation_utils.dart';
import 'package:booklog/shared/widgets/service_terms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WidgetRegisterUser extends StatefulWidget {
  const WidgetRegisterUser({super.key});

  @override
  _WidgetRegisterUserState createState() => _WidgetRegisterUserState();
}

class _WidgetRegisterUserState extends State<WidgetRegisterUser> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _performRegistration() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must agree to the terms to continue.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

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
        final response = await _authService.signUpWithEmail(
          _emailController.text.trim(),
          _passwordController.text,
          _usernameController.text.trim(),
        );

        if (response != null && response.user != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful! Check your email.'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration error. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          String errorMessage = 'Registration error: ${e.toString()}';
          
          // Friendly error messages
          if (e.toString().contains('email_address_invalid')) {
            errorMessage = 'Please enter a valid email address.';
          } else if (e.toString().contains('already_registered') || e.toString().contains('email_already_in_use')) {
            errorMessage = 'This email is already registered.';
          } else if (e.toString().contains('weak_password')) {
            errorMessage = 'Password must be at least 6 characters long.';
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
                'Sign up to Booklog',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    activeColor: Colors.amber,
                    checkColor: Colors.black,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'I agree with the '),
                          TextSpan(
                            text: 'terms of service',
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            title: const Text(
                                              'Terms of Service',
                                            ),
                                            content:
                                                const SingleChildScrollView(
                                                  child: ServiceTermsWidget(),
                                                ),
                                            actions: [
                                              TextButton(
                                                child: const Text('Close'),
                                                onPressed: () => Navigator.of(context).pop(),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                            style: const TextStyle(
                              color: Colors.amber,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _isLoading ? null : _performRegistration,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.amber)
                  : const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                style: TextButton.styleFrom(foregroundColor: Colors.amber),
                child: const Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

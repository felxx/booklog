import 'package:flutter/material.dart';
import 'package:booklog/config/routes.dart';
import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/core/database/dao/user_dao.dart';

class WidgetLoginUser extends StatefulWidget {
  const WidgetLoginUser({super.key});

  @override
  _WidgetLoginUserState createState() => _WidgetLoginUserState();
}

class _WidgetLoginUserState extends State<WidgetLoginUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserDAO _userDAO = UserDAO();
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      final user = await _userDAO.findByEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        _authService.login(user);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacementNamed(context, Routes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password.')),
        );
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Enter a valid email';
                  }
                  return null;
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: _performLogin,
                child: const Text('Login'),
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
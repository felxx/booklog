import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/screens/auth/login/presentation/widget_login_user.dart';
import 'package:booklog/screens/home/presentation/widget_home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    try {
      await _authService.initializeUser();
    } catch (e) {
      print('Error initializing authentication: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.amber),
        ),
      );
    }

    return StreamBuilder<AuthState>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.amber),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Authentication error',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final authState = snapshot.data;
        final isAuthenticated = authState?.session != null;

        if (isAuthenticated) {
          return const WidgetHome();
        } else {
          return const WidgetLoginUser();
        }
      },
    );
  }
}

import 'package:booklog/core/auth/supabase_service.dart';
import 'package:booklog/core/dto/user_dto.dart';
import 'package:booklog/core/utils/validation_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final SupabaseService _supabaseService = SupabaseService();
  UserDTO? _currentUser;

  Future<UserDTO?> getCurrentUser() async {
    if (_currentUser != null) return _currentUser;
    final user = _supabaseService.currentUser;
    if (user != null) {
      try {
        final userData = await _supabaseService
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();
        _currentUser = UserDTO.fromMap({
          'id': userData['id'],
          'username': userData['username'] ?? user.email,
          'email': user.email!,
          'password': '',
          'role': userData['role'] ?? 'USER',
        });
        return _currentUser;
      } catch (e) {
        if (e.toString().contains('PGRST116') || e.toString().contains('0 rows')) {
          try {
            await _supabaseService.from('profiles').insert({
              'id': user.id,
              'username': user.email,
              'email': user.email,
              'role': 'USER',
              'created_at': DateTime.now().toIso8601String(),
            });
            final userData = await _supabaseService
                .from('profiles')
                .select()
                .eq('id', user.id)
                .single();
            _currentUser = UserDTO.fromMap({
              'id': userData['id'],
              'username': userData['username'] ?? user.email,
              'email': user.email!,
              'password': '',
              'role': userData['role'] ?? 'USER',
            });
            return _currentUser;
          } catch (e2) {
            print('Error creating user profile: $e2');
            return null;
          }
        } else {
          print('Error fetching user: $e');
          return null;
        }
      }
    }
    return null;
  }


  Future<AuthResponse?> signInWithEmail(String email, String password) async {
    try {
      // Pre-validate email format before sending to Supabase
      if (!ValidationUtils.isValidEmail(email.trim())) {
        throw AuthApiException('Email address format is invalid');
      }

      final response = await _supabaseService.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
      
      if (response.user != null) {
        final userData = await _supabaseService
            .from('profiles')
            .select()
            .eq('id', response.user!.id)
            .single();
        _currentUser = UserDTO.fromMap({
          'id': userData['id'],
          'username': userData['username'] ?? response.user!.email,
          'email': response.user!.email!,
          'password': '',
          'role': userData['role'] ?? 'USER',
        });
      }
      
      return response;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<AuthResponse?> signUpWithEmail(String email, String password, String username) async {
    try {
      if (!ValidationUtils.isValidEmail(email.trim())) {
        throw AuthApiException('Email address format is invalid');
      }

      final passwordError = ValidationUtils.getPasswordErrorMessage(password);
      if (passwordError != null) {
        throw AuthApiException(passwordError);
      }

      final response = await _supabaseService.auth.signUp(
        email: email.trim().toLowerCase(),
        password: password,
      );
      
      if (response.user != null) {
        await _supabaseService.from('profiles').insert({
          'id': response.user!.id,
          'username': username,
          'email': email.trim().toLowerCase(),
          'role': 'USER',
          'created_at': DateTime.now().toIso8601String(),
        });
        _currentUser = UserDTO(
          username: username,
          email: email.trim().toLowerCase(),
          password: '',
          role: 'USER',
        );
      }
      
      return response;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _supabaseService.auth.signOut();
      _currentUser = null;
    } catch (e) {
      print('Logout error: $e');
    }
  }

  bool isLoggedIn() {
    return _supabaseService.isAuthenticated;
  }

  bool isAdmin() {
    return _currentUser?.role == 'ADMIN';
  }

  User? get supabaseUser => _supabaseService.currentUser;

  Stream<AuthState> get authStateChanges => _supabaseService.authStateChanges;

  Future<void> initializeUser() async {
    await getCurrentUser();
  }
}
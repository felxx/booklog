import 'package:booklog/core/dto/user_dto.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  UserDTO? currentUser;

  void login(UserDTO user) {
    currentUser = user;
  }

  void logout() {
    currentUser = null;
  }

  bool isLoggedIn() {
    return currentUser != null;
  }

  bool isAdmin() {
    return currentUser?.role == 'ADMIN';
  }
}
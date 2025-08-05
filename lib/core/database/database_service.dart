import 'package:booklog/core/database/dao/book_dao.dart';
import 'package:booklog/core/database/dao/user_dao.dart';
import 'package:booklog/core/database/dao/user_book_dao.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  
  factory DatabaseService() => _instance;
  
  DatabaseService._internal();

  final BookDAO _bookDAO = BookDAO();
  final UserDAO _userDAO = UserDAO();
  final UserBookDAO _userBookDAO = UserBookDAO();

  BookDAO get books => _bookDAO;
  UserDAO get users => _userDAO;
  UserBookDAO get userBooks => _userBookDAO;
}

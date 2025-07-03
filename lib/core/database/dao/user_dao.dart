import 'package:booklog/core/database/connection.dart';
import 'package:booklog/core/dto/user_dto.dart';

class UserDAO {
  final String tableName = 'users';
  final String columnId = 'id';
  final String columnUsername = 'username';
  final String columnEmail = 'email';
  final String columnPassword = 'password';

  Future<UserDTO> save(UserDTO user) async {
    final db = await Connection.get();
    final newId = await db.insert(tableName, user.toMap());
    return user.copyWith(id: newId);
  }

  Future<UserDTO?> findByEmail(String email) async {
    final db = await Connection.get();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnEmail = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return UserDTO.fromMap(maps.first);
    }
    return null;
  }

  Future<UserDTO?> findByEmailAndPassword(String email, String password) async {
    final db = await Connection.get();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return UserDTO.fromMap(maps.first);
    }
    return null;
  }
}
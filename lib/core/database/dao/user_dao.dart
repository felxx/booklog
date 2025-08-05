import 'package:booklog/core/database/connection.dart';
import 'package:booklog/core/dto/user_dto.dart';

class UserDAO {
  final String tableName = 'profiles';

  Future<UserDTO> save(UserDTO user) async {
    final response = await Connection.from(tableName)
        .upsert(user.toMap())
        .select()
        .single();
    
    return UserDTO.fromMap(response);
  }

  Future<UserDTO?> findByEmail(String email) async {
    try {
      final response = await Connection.from(tableName)
          .select()
          .eq('email', email)
          .single();
      
      return UserDTO.fromMap(response);
    } catch (e) {
      return null;
    }
  }

  Future<UserDTO?> findById(String id) async {
    try {
      final response = await Connection.from(tableName)
          .select()
          .eq('id', id)
          .single();
      
      return UserDTO.fromMap(response);
    } catch (e) {
      return null;
    }
  }

  Future<List<UserDTO>> findAll() async {
    final response = await Connection.from(tableName)
        .select()
        .order('username');

    return response.map<UserDTO>((item) => UserDTO.fromMap(item)).toList();
  }

  Future<void> delete(String id) async {
    await Connection.from(tableName)
        .delete()
        .eq('id', id);
  }
}
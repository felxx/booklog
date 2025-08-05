import 'package:booklog/core/database/connection.dart';
import 'package:booklog/core/dto/book_dto.dart';

class BookDAO {
  final String tableName = 'books';

  Future<BookDTO> save(BookDTO book) async {
    try {
      final response = await Connection.from(tableName)
          .upsert(book.toMap())
          .select()
          .single();
      
      return BookDTO.fromMap(response);
    } catch (e) {
      print('Error saving book: $e');
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await Connection.from(tableName)
          .delete()
          .eq('id', id);
    } catch (e) {
      print('Error deleting book: $e');
      rethrow;
    }
  }

  Future<List<BookDTO>> findAll() async {
    try {
      final response = await Connection.from(tableName)
          .select()
          .order('title');

      return response.map<BookDTO>((item) => BookDTO.fromMap(item)).toList();
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  Future<BookDTO?> findById(String id) async {
    try {
      final response = await Connection.from(tableName)
          .select()
          .eq('id', id)
          .single();
      
      return BookDTO.fromMap(response);
    } catch (e) {
      print('Error finding book by id: $e');
      return null;
    }
  }

  Future<List<BookDTO>> searchBooks(String query) async {
    try {
      final response = await Connection.from(tableName)
          .select()
          .or('title.ilike.%$query%,author.ilike.%$query%')
          .order('title');

      return response.map<BookDTO>((item) => BookDTO.fromMap(item)).toList();
    } catch (e) {
      print('Error searching books: $e');
      return [];
    }
  }
}
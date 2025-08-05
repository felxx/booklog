import 'package:booklog/core/database/connection.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/core/dto/user_book_dto.dart';

class UserBookDAO {
  final String userBooksTable = 'user_books';
  final String booksTable = 'books';

  Future<void> addBookToUser(String userId, String bookId, String status) async {
    final userBook = UserBookDTO(
      userId: userId,
      bookId: bookId,
      status: status,
    );
    
    await Connection.from(userBooksTable)
        .insert(userBook.toMap());
  }

  Future<void> removeBookFromUser(String userId, String bookId, String status) async {
    await Connection.from(userBooksTable)
        .delete()
        .eq('user_id', userId)
        .eq('book_id', bookId)
        .eq('status', status);
  }

  Future<List<BookDTO>> findBooksByUser(String userId, String status) async {
    final response = await Connection.from(userBooksTable)
        .select('books(*)')
        .eq('user_id', userId)
        .eq('status', status);

    return response.map<BookDTO>((item) => BookDTO.fromMap(item['books'])).toList();
  }

  Future<bool> isBookInUserList(String userId, String bookId, String status) async {
    try {
      await Connection.from(userBooksTable)
          .select()
          .eq('user_id', userId)
          .eq('book_id', bookId)
          .eq('status', status)
          .single();
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<UserBookDTO>> findUserBooks(String userId) async {
    final response = await Connection.from(userBooksTable)
        .select()
        .eq('user_id', userId);

    return response.map<UserBookDTO>((item) => UserBookDTO.fromMap(item)).toList();
  }

  Future<void> updateBookStatus(String userId, String bookId, String oldStatus, String newStatus) async {
    await Connection.from(userBooksTable)
        .update({'status': newStatus})
        .eq('user_id', userId)
        .eq('book_id', bookId)
        .eq('status', oldStatus);
  }
}
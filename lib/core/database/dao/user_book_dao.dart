import 'package:booklog/core/database/connection.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/core/dto/user_book_dto.dart';

class UserBookDAO {
  final String userBooksTable = 'user_books';
  final String booksTable = 'books';

  Future<void> addBookToUser(int userId, int bookId, String status) async {
    final db = await Connection.get();
    final userBook = UserBookDTO(
      userId: userId,
      bookId: bookId,
      status: status,
    );
    await db.insert(
      userBooksTable,
      userBook.toMap(),
    );
  }

  Future<void> removeBookFromUser(int userId, int bookId, String status) async {
    final db = await Connection.get();
    await db.delete(
      userBooksTable,
      where: 'user_id = ? AND book_id = ? AND status = ?',
      whereArgs: [userId, bookId, status],
    );
  }

  Future<List<BookDTO>> findBooksByUser(int userId, String status) async {
    final db = await Connection.get();
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT b.*
      FROM $booksTable b
      INNER JOIN $userBooksTable ub ON b.id = ub.book_id
      WHERE ub.user_id = ? AND ub.status = ?
    ''', [userId, status]);

    return List.generate(maps.length, (i) {
      return BookDTO.fromMap(maps[i]);
    });
  }

  Future<bool> isBookInUserList(int userId, int bookId, String status) async {
    final db = await Connection.get();
    final List<Map<String, dynamic>> maps = await db.query(
      userBooksTable,
      where: 'user_id = ? AND book_id = ? AND status = ?',
      whereArgs: [userId, bookId, status],
    );
    return maps.isNotEmpty;
  }
}
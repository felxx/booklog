import 'package:booklog/core/database/connection.dart';
import 'package:booklog/core/dto/book_dto.dart';

class BookDAO {
  final String tableName = 'books';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnAuthor = 'author';
  final String columnYear = 'year';
  final String columnIsbn = 'isbn';

  Future<BookDTO> save(BookDTO book) async {
    final db = await Connection.get();
    if (book.id == null) {
      final newId = await db.insert(tableName, book.toMap());
      return book.copyWith(id: newId);
    } else {
      await db.update(
        tableName,
        book.toMap(),
        where: '$columnId = ?',
        whereArgs: [book.id],
      );
      return book;
    }
  }

  Future<void> delete(int id) async {
    final db = await Connection.get();
    await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<BookDTO>> findAll() async {
    final db = await Connection.get();
    final List<Map<String, dynamic>> maps = await db.query(tableName, orderBy: 'title');

    return List.generate(maps.length, (i) {
      return BookDTO.fromMap(maps[i]);
    });
  }

  Future<BookDTO?> findById(int id) async {
    final db = await Connection.get();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BookDTO.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
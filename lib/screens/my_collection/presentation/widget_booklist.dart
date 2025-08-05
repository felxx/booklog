import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/core/database/dao/user_book_dao.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';

class WidgetBooklist extends StatefulWidget {
  const WidgetBooklist({super.key});

  @override
  State<WidgetBooklist> createState() => _WidgetBooklistState();
}

class _WidgetBooklistState extends State<WidgetBooklist> {
  final UserBookDAO _userBookDAO = UserBookDAO();
  final AuthService _authService = AuthService();
  List<BookDTO> _collectionBooks = [];

  @override
  void initState() {
    super.initState();
    _loadCollection();
  }

  Future<void> _loadCollection() async {
    if (_authService.isLoggedIn()) {
      final books = await _userBookDAO.findBooksByUser(
          _authService.currentUser!.id!, 'collection');
      setState(() {
        _collectionBooks = books;
      });
    }
  }

  Future<void> _removeBookFromCollection(String bookId) async {
    if (_authService.isLoggedIn()) {
      await _userBookDAO.removeBookFromUser(
          _authService.currentUser!.id!, bookId, 'collection');
      _loadCollection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
      ),
      body: _authService.isLoggedIn()
          ? _collectionBooks.isEmpty
              ? const Center(child: Text('Your collection is empty.'))
              : ListView.builder(
                  itemCount: _collectionBooks.length,
                  itemBuilder: (context, index) {
                    final book = _collectionBooks[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeBookFromCollection(book.id!),
                      ),
                    );
                  },
                )
          : const Center(
              child: Text('Please log in to see your collection.'),
            ),
      floatingActionButton: const WidgetMenu(),
    );
  }
}
import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/core/database/dao/user_book_dao.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';

class WidgetWishlist extends StatefulWidget {
  const WidgetWishlist({super.key});

  @override
  State<WidgetWishlist> createState() => _WidgetWishlistState();
}

class _WidgetWishlistState extends State<WidgetWishlist> {
  final UserBookDAO _userBookDAO = UserBookDAO();
  final AuthService _authService = AuthService();
  List<BookDTO> _wishlistBooks = [];

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    if (_authService.isLoggedIn()) {
      final user = await _authService.getCurrentUser();
      if (user != null && user.id != null) {
        final books = await _userBookDAO.findBooksByUser(user.id!, 'wishlist');
        setState(() {
          _wishlistBooks = books;
        });
      }
    }
  }

  Future<void> _removeBookFromWishlist(String bookId) async {
    if (_authService.isLoggedIn()) {
      final user = await _authService.getCurrentUser();
      if (user != null && user.id != null) {
        await _userBookDAO.removeBookFromUser(user.id!, bookId, 'wishlist');
        _loadWishlist();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: _authService.isLoggedIn()
          ? _wishlistBooks.isEmpty
              ? const Center(child: Text('Your wishlist is empty.'))
              : ListView.builder(
                  itemCount: _wishlistBooks.length,
                  itemBuilder: (context, index) {
                    final book = _wishlistBooks[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeBookFromWishlist(book.id!),
                      ),
                    );
                  },
                )
          : const Center(
              child: Text('Please log in to see your wishlist.'),
            ),
      floatingActionButton: const WidgetMenu(),
    );
  }
}
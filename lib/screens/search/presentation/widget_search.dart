import 'package:booklog/screens/search/presentation/add_book_dialog.dart';
import 'package:booklog/screens/search/presentation/edit_book_dialog.dart';
import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/core/database/dao/book_dao.dart';
import 'package:booklog/core/auth/auth_service.dart';
import 'package:booklog/core/database/dao/user_book_dao.dart';

class WidgetSearch extends StatefulWidget {
  const WidgetSearch({super.key});

  @override
  State<WidgetSearch> createState() => _WidgetSearchState();
}

class _WidgetSearchState extends State<WidgetSearch> {
  final BookDAO _bookDAO = BookDAO();
  final UserBookDAO _userBookDAO = UserBookDAO();
  final AuthService _authService = AuthService();
  List<BookDTO> _books = [];

  @override
  void initState() {
    super.initState();
    _refreshBookList();
  }

  Future<void> _refreshBookList() async {
    try {
      final bookList = await _bookDAO.findAll();
      setState(() {
        _books = bookList;
      });
      // debugPrint('Loaded ${_books.length} books');
    } catch (e) {
      // debugPrint('Error loading books: $e');
      setState(() {
        _books = [];
      });
    }
  }

  Future<void> _deleteBook(String id) async {
    await _bookDAO.delete(id);
    _refreshBookList();
  }

  Future<void> _saveBook(BookDTO book) async {
    await _bookDAO.save(book);
    _refreshBookList();
  }

  Future<void> _addBookToUserList(String bookId, String status) async {
    final user = await _authService.getCurrentUser();
    if (user == null || user.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to add books.')),
      );
      return;
    }
    final userId = user.id!;

    try {
      if (await _userBookDAO.isBookInUserList(userId, bookId, status)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Book is already in your $status.')),
        );
        return;
      }

      await _userBookDAO.addBookToUser(userId, bookId, status);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book added to $status!')),
      );
      // Atualiza a lista após adicionar
      await _refreshBookList();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding book: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = _authService.isAdmin();
    bool isUserLoggedIn = _authService.isLoggedIn();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text("${book.author}, ${book.year}"),
            trailing: _buildTrailingWidget(book, isAdmin, isUserLoggedIn),
            onTap: () => _showBookDetailsDialog(context, book),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAdmin)
            FloatingActionButton(
              onPressed: () => _showAddBookDialog(context),
              tooltip: 'Add Book',
              heroTag: 'add_book_fab',
              child: const Icon(Icons.add),
            ),
          if (isAdmin) const SizedBox(height: 16),
          const WidgetMenu(),
        ],
      ),
    );
  }

  Widget? _buildTrailingWidget(BookDTO book, bool isAdmin, bool isUserLoggedIn) {
    if (!isUserLoggedIn) return null;

    if (isAdmin) {
      return SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => _showEditBookDialog(context, book),
              icon: const Icon(Icons.edit),
              color: Colors.amber,
              tooltip: 'Edit',
            ),
            IconButton(
              onPressed: () => _showDeleteConfirmationDialog(context, book.id!),
              icon: const Icon(Icons.delete),
              color: Colors.red,
              tooltip: 'Delete',
            )
          ],
        ),
      );
    } else {
      return SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => _addBookToUserList(book.id!, 'collection'),
              icon: const Icon(Icons.collections_bookmark),
              color: Colors.green,
              tooltip: 'Add to Collection',
            ),
            IconButton(
              onPressed: () => _addBookToUserList(book.id!, 'wishlist'),
              icon: const Icon(Icons.bookmark_add),
              color: Colors.blue,
              tooltip: 'Add to Wishlist',
            )
          ],
        ),
      );
    }
  }

  void _showAddBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddBookDialog(
          onBookAdded: (BookDTO newBook) {
            _saveBook(newBook);
          },
        );
      },
    );
  }

  void _showEditBookDialog(BuildContext context, BookDTO book) {
    showDialog(
      context: context,
      builder: (dialogContext) => EditBookDialog(
        book: book,
        onBookSaved: (updatedBook) {
          _saveBook(updatedBook);
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String bookId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteBook(bookId);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showBookDetailsDialog(BuildContext context, BookDTO book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(book.title),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Author: ${book.author}"),
              Text("Year: ${book.year}"),
              Text("ISBN: ${book.isbn}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
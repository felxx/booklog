import 'package:booklog/screens/search/presentation/add_book_dialog.dart';
import 'package:booklog/screens/search/presentation/edit_book_dialog.dart';
import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/core/database/dao/book_dao.dart';

class WidgetSearch extends StatefulWidget {
  const WidgetSearch({super.key});

  @override
  State<WidgetSearch> createState() => _WidgetSearchState();
}

class _WidgetSearchState extends State<WidgetSearch> {
  final BookDAO _bookDAO = BookDAO();
  List<BookDTO> _books = [];

  @override
  void initState() {
    super.initState();
    _refreshBookList();
  }

  Future<void> _refreshBookList() async {
    final bookList = await _bookDAO.findAll();
    setState(() {
      _books = bookList;
    });
  }

  Future<void> _deleteBook(int id) async {
    await _bookDAO.delete(id);
    _refreshBookList();
  }

  Future<void> _saveBook(BookDTO book) async {
    await _bookDAO.save(book);
    _refreshBookList();
  }

  @override
  Widget build(BuildContext context) {
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
            trailing: SizedBox(
              width: 80,
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
            ),
            onTap: () => _showBookDetailsDialog(context, book),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showAddBookDialog(context),
            tooltip: 'Add Book',
            heroTag: 'add_book_fab',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          const WidgetMenu(),
        ],
      ),
    );
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

  void _showDeleteConfirmationDialog(BuildContext context, int bookId) {
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
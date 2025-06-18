import 'package:booklog/screens/booklist/presentation/add_book_dialog.dart';
import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';
import 'package:booklog/core/dto/book_dto.dart';
import 'package:booklog/core/database/dao/book_dao.dart';

class WidgetBooklist extends StatefulWidget {
  const WidgetBooklist({super.key});

  @override
  State<WidgetBooklist> createState() => _WidgetBooklistState();
}

class _WidgetBooklistState extends State<WidgetBooklist> {
  final BookDAO _bookDAO = BookDAO();
  List<BookDTO> _books = [];

  final _formKey = GlobalKey<FormState>();

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
        title: const Text('Minha Coleção'),
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
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: () => _showDeleteConfirmationDialog(context, book.id!),
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    tooltip: 'Deletar',
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
            tooltip: 'Adicionar Livro',
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
    final titleController = TextEditingController(text: book.title);
    final authorController = TextEditingController(text: book.author);
    final yearController = TextEditingController(text: book.year.toString());
    final isbnController = TextEditingController(text: book.isbn);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Livro'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) => value == null || value.isEmpty ? 'Insira o título' : null,
                ),
                TextFormField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Autor'),
                  validator: (value) => value == null || value.isEmpty ? 'Insira o autor' : null,
                ),
                TextFormField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'Ano'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Insira o ano' : null,
                ),
                TextFormField(
                  controller: isbnController,
                  decoration: const InputDecoration(labelText: 'ISBN'),
                  validator: (value) => value == null || value.isEmpty ? 'Insira o ISBN' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final updatedBook = book.copyWith(
                  title: titleController.text,
                  author: authorController.text,
                  year: int.tryParse(yearController.text) ?? book.year,
                  isbn: isbnController.text,
                );
                _saveBook(updatedBook);
                Navigator.of(context).pop();
              }
            },
            style: TextButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text('Confirmar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int bookId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja realmente excluir?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteBook(bookId);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text('Confirmar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Cancelar'),
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
              Text("Autor: ${book.author}"),
              Text("Ano: ${book.year}"),
              Text("ISBN: ${book.isbn}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:booklog/core/dto/book_dto.dart';

typedef OnBookSavedCallback = void Function(BookDTO updatedBook);

class EditBookDialog extends StatefulWidget {
  final BookDTO book;
  final OnBookSavedCallback onBookSaved;

  const EditBookDialog({
    super.key,
    required this.book,
    required this.onBookSaved,
  });

  @override
  State<EditBookDialog> createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;
  late TextEditingController _isbnController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _yearController = TextEditingController(text: widget.book.year.toString());
    _isbnController = TextEditingController(text: widget.book.isbn);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      final updatedBook = widget.book.copyWith(
        title: _titleController.text,
        author: _authorController.text,
        publishedYear: int.tryParse(_yearController.text) ?? widget.book.publishedYear,
        isbn: _isbnController.text,
      );
      
      widget.onBookSaved(updatedBook);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Book'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the title' : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the author' : null,
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the year' : null,
              ),
              TextFormField(
                controller: _isbnController,
                decoration: const InputDecoration(labelText: 'ISBN'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter the ISBN' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _onConfirm,
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
    );
  }
}
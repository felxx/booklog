import 'package:flutter/material.dart';
import '../../../core/dto/book_dto.dart';

typedef OnBookAddedCallback = void Function(BookDTO book);

class AddBookDialog extends StatefulWidget {
  final OnBookAddedCallback onBookAdded;

  const AddBookDialog({
    Key? key,
    required this.onBookAdded,
  }) : super(key: key);

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;
  late TextEditingController _isbnController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _yearController = TextEditingController();
    _isbnController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    _isbnController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _titleController.clear();
    _authorController.clear();
    _yearController.clear();
    _isbnController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Book'),
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
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter the book title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  hintText: 'Enter the book author',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  hintText: 'Enter the book publication year',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the publication year';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _isbnController,
                decoration: const InputDecoration(
                  labelText: 'ISBN',
                  hintText: 'Enter the book ISBN',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ISBN';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final book = BookDTO(
                title: _titleController.text,
                author: _authorController.text,
                year: int.tryParse(_yearController.text) ?? 0,
                isbn: _isbnController.text,
              );
              widget.onBookAdded(book);
              _clearFields();
              Navigator.of(context).pop();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Confirm'),
        ),
        TextButton(
          onPressed: () {
            _clearFields();
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';

class WidgetHome extends StatelessWidget{
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
              margin: const EdgeInsets.all(30.0),
              child: const Text(
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 30),
                'Booklog 📔\n'
                'Organize your book collection, whether physical or digital.\n'
                '\n'
                '• Add books to your collection and create lists to organize them however you want.\n'
                '• Statistics: Track your reading progress and statistics of books read.\n'
                '• Wishlist: Create a wishlist with books you want to read in the future.\n'
                '• Advanced search: Easily find books by author, title, genres.\n',
              ),
            ),
      floatingActionButton: const WidgetMenu(),
    );
  }
}
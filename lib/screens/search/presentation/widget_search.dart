import 'package:booklog/shared/widgets/widget_menu.dart';
import 'package:flutter/material.dart';

class WidgetSearch extends StatelessWidget {
  const WidgetSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Coming soon!', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: const WidgetMenu(),
    );
  }
}
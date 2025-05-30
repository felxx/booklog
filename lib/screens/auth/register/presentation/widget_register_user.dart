import 'package:flutter/material.dart';

class WidgetRegisterUser extends StatefulWidget{
  const WidgetRegisterUser({super.key});

  @override
  _WidgetRegisterUser createState() => _WidgetRegisterUser();
}

class _WidgetRegisterUser extends State<WidgetRegisterUser>{

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(title: const Text('Cadastro'),),
      body: const Align(
        alignment: Alignment.topCenter,
        child: Icon(Icons.person)
      )
    );
  }
}
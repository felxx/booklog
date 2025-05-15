import 'package:flutter/material.dart';

class WidgetRegisterUser extends StatefulWidget{
  const WidgetRegisterUser({super.key});

  @override
  _WidgetRegisterUser createState() => _WidgetRegisterUser();
}

class _WidgetRegisterUser extends State<WidgetRegisterUser>{
  final _formKey = GlobalKey<FormState>();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro'),),
      body: Form(key: _formKey, autovalidateMode: AutovalidateMode.onUserInteraction, child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Usuário',
              hintText: 'Digite seu nome de usuário'
            ),
            validator: (value) {
              if (value == null || value.isEmpty){
                return 'Por favor, insira o usuário';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'E-mail',
              hintText: 'Digite seu e-mail'
            ),
            validator: (value) {
              if (value == null || value.isEmpty){
                return 'Por favor, insira o e-mail';
              }
              if (!value.contains('@')){
                return 'Por favor, insira um e-mail válido';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            controller: _senhaController,
            decoration: const InputDecoration(
              labelText: 'Senha',
              hintText: 'Digite sua senha'
            ),
            validator: (value) {
              if(value == null || value.isEmpty){
                return 'Por favor, insira uma senha';
              }
              if(value.length < 8){
                return 'Insira uma senha com 8 digitos ou mais';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirme sua senha',
              hintText: 'Redigite sua senha'
            ),
            validator: (value) {
              if(value == null || value.isEmpty){
                return 'Por favor, redigite a senha';
              }
              if(value != _senhaController.text){
                return 'As senhas não coincidem';
              }
              return null;
            },
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Salvar'))
        ],
      )),
    );
  }
}
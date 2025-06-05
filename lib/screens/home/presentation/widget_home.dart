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
                'Organize sua coleção de livros, seja física ou virtual.\n'
                '\n'
                '• Adicione livros à sua coleção e crie listas para organizá-la da forma que quiser.\n'
                '• Estatísticas: Acompanhe o progresso de leitura e estatísticas de livros lidos.\n'
                '• Wishlist: Crie uma lista de desejos com os livros que deseja ler futuramente.\n'
                '• Pesquisa avançada: Encontre facilmente livros por autor, título, gêneros.\n',
              ),
            ),
      floatingActionButton: const WidgetMenu(),
    );
  }
}
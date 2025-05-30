import 'package:booklog/config/routes.dart';
import 'package:flutter/material.dart';

class WidgetHome extends StatelessWidget{
  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    Widget createMenuButton({required IconData icon, required String name, required String route}){
      return ListTile(
        leading: Icon(icon),
        title: Text(name),
        onTap: () => Navigator.pushNamed(context, route),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24))
            ),
            createMenuButton(icon: Icons.my_library_books, name: 'Lista de Livros', route: Routes.booklist),
            createMenuButton(icon: Icons.person, name: 'Cadastre-se', route: Routes.registerUser),
          ],
        ),
      ),
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
          );
  }
}
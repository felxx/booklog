import 'package:flutter/material.dart';

class WidgetBooklist extends StatefulWidget{
  const WidgetBooklist({super.key});

  @override
  _WidgetBooklist createState() => _WidgetBooklist();
}

class _WidgetBooklist extends State<WidgetBooklist>{
  var livros = [
    {
    'titulo': 'Memórias Póstumas de Brás Cubas',
    'autor': 'Machado de Assis',
    'ano': '1881',  
    'isbn': '978-8582850015'  
    },  
    {  
    'titulo': 'Sidarta',
    'autor': 'Herman Hesse',
    'ano': '1922',  
    'isbn': '978-8501118295'  
    },  
    {  
    'titulo': 'Crime e castigo',
    'autor': 'Fiódor Dostoiévski',
    'ano': '1866',  
    'isbn': '978-8573266467'  
    }
  ];

  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _anoController = TextEditingController();
  final _isbnController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Livros'),
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(livros[index]['titulo'].toString()),
          subtitle: Text("${livros[index]['autor']}, ${livros[index]['ano']}"),
          trailing: SizedBox(
            width: 80,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  _tituloController.text = livros[index]['titulo'].toString();
                  _autorController.text = livros[index]['autor'].toString();
                  _anoController.text = livros[index]['ano'].toString();
                  _isbnController.text = livros[index]['isbn'].toString();

                  showDialog(
                    context: context, builder: (context) => AlertDialog(
                      title: const Text('Editar Livro'),
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Form(key: _formKey, autovalidateMode: AutovalidateMode.onUserInteraction, child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _tituloController,
                              decoration: const InputDecoration(
                                labelText: 'Título',
                                hintText: 'Insira o título do livro'
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Por favor, insira o título';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _autorController,
                              decoration: const InputDecoration(
                                labelText: 'Autor',
                                hintText: 'Insira o autor do livro'
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Por favor, insira o autor';
                                }
                                return null;
                              },                    
                            ),
                            TextFormField(
                              controller: _anoController,
                              decoration: const InputDecoration(
                                labelText: 'Ano',
                                hintText: 'Insira o ano em que o livro foi publicado',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Por favor, insira o ano em que o livro foi publicado';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _isbnController,
                              decoration: const InputDecoration(
                                labelText: 'ISBN',
                                hintText: 'Insira a ISBN do livro'
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Por favor, insira a ISBN';
                                }
                                return null;
                              },
                            ),   
                          ],
                        )),                             
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              setState((){
                                livros[index] = {
                                  'titulo': _tituloController.text,
                                  'autor': _autorController.text,
                                  'ano': _anoController.text,
                                  'isbn': _isbnController.text,
                                };
                              });
                                Navigator.of(context).pop();

                                _tituloController.clear();
                                _autorController.clear();
                                _anoController.clear();
                                _isbnController.clear();

                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white // Define the text color
                          ),
                          child: const Text('Confirmar')
                        ),
                        TextButton(
                          onPressed: () {
                              Navigator.of(context).pop();

                              _tituloController.clear();
                              _autorController.clear();
                              _anoController.clear();
                              _isbnController.clear();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white // Define the text color
                          ),
                          child: const Text('Cancelar')
                        )
                      ],
                    )
                  );
                }, icon: const Icon(Icons.edit), color: Colors.amber, tooltip: 'Editar',),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) => AlertDialog(
                    title: const Text('Deseja realmente excluir?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState((){
                              livros.removeAt(index);
                              Navigator.of(context).pop();
                            }
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white // Define the text color
                        ),
                        child: const Text('Confirmar')
                      ),
                      TextButton(
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white // Define the text color
                        ),
                        child: const Text('Cancelar')
                      )
                    ],
                  ));
                }, icon: const Icon(Icons.delete), color: Colors.red, tooltip: 'Deletar',)
              ],
            ),
          ),
          onTap: (){
            showDialog(context: context, builder: (context) => AlertDialog(
              title: Text(livros[index]['titulo'].toString()),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(livros[index]['autor'].toString()),
                    Text(livros[index]['ano'].toString()),
                    Text(livros[index]['isbn'].toString())
                  ],
                ),
              )
            )
            );
          },
        )
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
          context: context, builder: (context) => AlertDialog(
            title: const Text('Adicionar Livro'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(key: _formKey, autovalidateMode: AutovalidateMode.onUserInteraction, child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _tituloController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      hintText: 'Insira o título do livro'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Por favor, insira o título';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _autorController,
                    decoration: const InputDecoration(
                      labelText: 'Autor',
                      hintText: 'Insira o autor do livro'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Por favor, insira o autor';
                      }
                      return null;
                    },                    
                  ),
                  TextFormField(
                    controller: _anoController,
                    decoration: const InputDecoration(
                      labelText: 'Ano',
                      hintText: 'Insira o ano em que o livro foi publicado',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Por favor, insira o ano em que o livro foi publicado';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _isbnController,
                    decoration: const InputDecoration(
                      labelText: 'ISBN',
                      hintText: 'Insira a ISBN do livro'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Por favor, insira a ISBN';
                      }
                      return null;
                    },
                  ),   
                ],
              )),                             
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    setState((){
                      livros.add({
                          'titulo': _tituloController.text,
                          'autor': _autorController.text,
                          'ano': _anoController.text,
                          'isbn': _isbnController.text,
                      });
                    });

                      _tituloController.clear();
                      _autorController.clear();
                      _anoController.clear();
                      _isbnController.clear();

                      Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white // Define the text color
                ),
                child: const Text('Confirmar')
              ),
              TextButton(
                onPressed: () {
                    _tituloController.clear();
                    _autorController.clear();
                    _anoController.clear();
                    _isbnController.clear();

                    Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white // Define the text color
                ),
                child: const Text('Cancelar')
              )
            ],
          )
        );
      }, backgroundColor: Colors.amber, tooltip: 'Adicionar Livro', child: const Icon(Icons.add)),
    );
  }
}
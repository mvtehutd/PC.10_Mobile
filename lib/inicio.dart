import 'package:flutter/material.dart';
import 'package:pessoas/persistencia/pessoa.dart';
import 'package:pessoas/viewModel.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = Provider.of<ViewModel>(context);

    final _nameController = TextEditingController();
    final _ageController = TextEditingController();

    void _addPerson() {
      final name = _nameController.text;
      final age = int.tryParse(_ageController.text) ?? 0;

      if (name.isNotEmpty) {
        viewModel.addPerson(name, age);
        _nameController.clear();
        _ageController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Linha 1: TextField para Nome
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16), // Espaçamento entre os TextFields
            // Linha 2: TextField para Idade
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16), // Espaçamento entre o TextField e o botão
            // Linha 3: Botão Adicionar
            ElevatedButton(
              onPressed: _addPerson,
              child: Text('Add'),
            ),
            SizedBox(height: 16), // Espaçamento abaixo do botão
            // Lista de pessoas
            Expanded(
              child: StreamBuilder<List<Person>>(
                stream: viewModel.personsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final persons = snapshot.data!;
                    return ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        final item = persons[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(item.nome),
                            subtitle: Text('Idade: ${item.idade}'),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

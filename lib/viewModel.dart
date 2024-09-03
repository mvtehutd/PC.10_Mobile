import 'package:flutter/cupertino.dart';
import 'package:pessoas/persistencia/pessoa.dart';
import 'package:pessoas/persistencia/pessoaRepository.dart';

class ViewModel extends ChangeNotifier {
  final PersonRepository repository;
  Stream<List<Person>>? _personsStream;

  ViewModel(this.repository) {
    _personsStream = repository.getAllPersons();
  }

  Stream<List<Person>> get personsStream => _personsStream!;

  Future<void> addPerson(String nome, int idade) async {
    final person = Person(nome, idade);
    await repository.insert(person);
    notifyListeners(); // Notifica os listeners de qualquer alteração
  }
}

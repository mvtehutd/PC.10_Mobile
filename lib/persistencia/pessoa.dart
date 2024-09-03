import 'package:floor/floor.dart';

@entity
class Person {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String nome;
  final int idade;

  Person(this.nome, this.idade);
}

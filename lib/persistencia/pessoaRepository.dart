import 'package:pessoas/persistencia/pessoa.dart';
import 'package:pessoas/persistencia/pessoaDao.dart';
import 'appDatabase.dart';

class PersonRepository {
  late AppDatabase database;
  late PersonDao personDao;

  Future<void> initialize() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    personDao = database.personDao;
  }

  Future<void> insert(Person pessoa) => personDao.insertPerson(pessoa);

  Stream<List<Person>> getAllPersons() => personDao.findAllPersons();
}

import 'package:flutter/material.dart';
import 'package:pessoas/persistencia/pessoaRepository.dart';
import 'package:pessoas/viewModel.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = PersonRepository();
  await repository.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ViewModel(repository)),
    ],
    child: const MyApp(),
  ));
}

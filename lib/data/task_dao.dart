import 'package:flutter_game_course/components/task.dart';
import 'package:flutter_game_course/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTERGER, '
      '$_image TEXT)';
  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    print('Acessando o findAll');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.name);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('A Tarefa não existia.');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print('A Tarefa já existia!');
      return await bancoDeDados.update(_tablename, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.name]);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('Convertendo Tarefa em Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.name;
    mapaDeTarefas[_difficulty] = tarefa.difficulty;
    mapaDeTarefas[_image] = tarefa.photo;
    print('Mapa de Tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Pocurando dados no banco de dados... encontrado $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('Convertendo to List:');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas $tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
    print('Tarefa Encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando Tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}



import 'package:dio/dio.dart';

import 'package:study_architecture/data/todos.dart';

import 'api_constants.dart';

class TodoRepository {
  final Dio dio;

  TodoRepository({required this.dio});

  Future<List<Todo>> getTodos() async {
    final response = await dio.get(ApiConstants.getTodos);

    if (response.statusCode == 200) {
      final json = response.data;

      final todoList = <Todo>[];

      for (final item in json) {
        final todo = Todo.fromJson(item);
        todoList.add(todo);
      }

      return todoList;
    } else {
      throw Exception('Failed to load');
    }
  }

}










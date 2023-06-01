
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:study_architecture/features/post/bloc/todos_state.dart';

import '../../../data/todo_repository.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoLoadingState());

  final _todoRepository = TodoRepository(dio: Dio());

  Future<void> fetchPostList() async {
    emit(TodoLoadingState());

    try {
      final todoList = await _todoRepository.getTodos();

      emit(TodoSuccessState(todoList: todoList));
    } catch (e) {
      emit(TodoErrorState(errorText: e.toString()));
    }
  }
}

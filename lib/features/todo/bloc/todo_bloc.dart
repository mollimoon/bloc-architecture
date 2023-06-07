
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:study_architecture/features/todo/bloc/todo_event.dart';
import 'package:study_architecture/features/todo/bloc/todos_state.dart';


import '../../../data/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoadingState()) {
    on<FetchTodoEvent>((event, emit) => _fetchTodoList(emit)); //events here; through the callback change states
  }

  final _todoRepository = TodoRepository(dio: Dio());

  Future<void> _fetchTodoList(Emitter emit) async {
    emit(TodoLoadingState());

    try {
      final todoList = await _todoRepository.getTodos();

      emit(TodoSuccessState(todoList: todoList));
    } catch (e) {
      emit(TodoErrorState(errorText: e.toString()));
    }
  }
}

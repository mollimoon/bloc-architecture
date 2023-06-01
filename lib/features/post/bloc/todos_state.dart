import 'package:equatable/equatable.dart';
import 'package:study_architecture/data/todos.dart';


class TodoState {}

class TodoLoadingState extends TodoState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class TodoSuccessState extends TodoState with EquatableMixin {
  final List<Todo> todoList;
  TodoSuccessState({required this.todoList});

  @override
  List<Object?> get props => [todoList];
}

class TodoErrorState extends TodoState with EquatableMixin {
  final String errorText;
  TodoErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}
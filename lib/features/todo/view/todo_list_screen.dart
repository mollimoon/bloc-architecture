import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_architecture/features/todo/bloc/todos_cubit.dart';


import '../bloc/todos_state.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late final TodoCubit _todoCubit;

  @override
  void initState() {
    super.initState();

    _todoCubit = TodoCubit();

    Future(_todoCubit.fetchPostList);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _todoCubit.fetchPostList();
      },
      child: Scaffold(
        backgroundColor: Colors.green[50],
        body: BlocBuilder<TodoCubit, TodoState>(
          bloc: _todoCubit,
          builder: (context, state) {
            if (state is TodoSuccessState) {
              final items = state.todoList;

              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.black,
                    child: ListTile(
                      leading: Text(items[index].id.toString()),
                      title: Text(items[index].title, style: const TextStyle(fontSize: 16),),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            items[index].completed ? IconButton(onPressed: () {}, icon: const Icon(Icons.check))
                            : IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
                          ],
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      tileColor: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                itemCount: items.length,
              );
            }
            if (state is TodoErrorState) {
              return const Text('Something is wrong. Try again');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:study_architecture/features/post/view/post_list_screen.dart';
import 'package:study_architecture/features/post/view/todo_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Индекс выбранной вкладки
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Индекс выбранной вкладки
  final List<Widget> screens = [
    // Список виджетов (экранов)
    const PostListScreen(),
    const TodoListScreen(),
  ];

  void onTabTapped(int index) {
    // Обработчик нажатий на вкладки
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex], // Отображение выбранного экрана
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lime[50],
        onTap: onTabTapped, // Метод, который будет вызываться при нажатии на вкладки
        currentIndex: _currentIndex, // Индекс выбранной вкладки
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_post_office),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Todo',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/category_button_list.dart';
import 'package:flutter_todo/widgets/task_card.dart';

class CategorySelectionScreen extends StatelessWidget {
  CategorySelectionScreen({super.key});

  // 'const'를 제거하고 'final'로 변경
  final List<Map<String, dynamic>> categories = [
    {
      'text': 'Work',
      'icon': Icons.work,
      'tasks': 5,
      'backgroundColor': Colors.red,
    },
    {
      'text': 'Personal',
      'icon': Icons.person,
      'tasks': 3,
      'backgroundColor': Colors.green,
    },
    {
      'text': 'Shopping',
      'icon': Icons.shopping_cart,
      'tasks': 1,
      'backgroundColor': Colors.orange,
    },
    {
      'text': 'Fitness',
      'icon': Icons.fitness_center,
      'tasks': 2,
      'backgroundColor': Colors.purple,
    },
    // 추가 카테고리를 여기에 계속 추가할 수 있습니다.
  ];

  final List<Map<String, dynamic>> todayTasks = [
    {'title': 'Sketching', 'completed': 2, 'total': 4, 'color': Colors.green},
    {
      'title': 'Wireframing',
      'completed': 1,
      'total': 2,
      'color': Colors.purple
    },
    {
      'title': 'Visual Design',
      'completed': 4,
      'total': 4,
      'color': Colors.orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Category List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CategoryButtonList(categories: categories),
                  const SizedBox(height: 32),
                  const Text(
                    "Today's Task",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: todayTasks.map((task) {
                      return TaskCard(
                        title: task['title'],
                        completed: task['completed'],
                        total: task['total'],
                        color: task['color'],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined),
            label: 'todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (int index) {
          // Handle tap events here
        },
      ),
    );
  }
}

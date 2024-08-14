import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/category_button_list.dart';
import 'package:flutter_todo/widgets/task_card.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  final List<Map<String, String>> categories = const [
    {'title': 'Work', 'date': '2024-07-22', 'category': 'work'},
    {'title': 'Personal', 'date': '2024-07-22', 'category': 'personal'},
    {'title': 'Study', 'date': '2024-07-22', 'category': 'study'},
  ];

  final List<Map<String, dynamic>> todayTasks = const [
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
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

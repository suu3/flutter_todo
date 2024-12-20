import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/auth.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:flutter_todo/widgets/category_button_list.dart';
import 'package:flutter_todo/widgets/task_card.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_todo/constants/routes.dart' as routes;

class CategorySelectionScreen extends ConsumerStatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  CategorySelectionScreenState createState() => CategorySelectionScreenState();
}

class CategorySelectionScreenState
    extends ConsumerState<CategorySelectionScreen> {
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
    {
      'title': 'Work',
      'completed': 2,
      'total': 4,
      'color': Colors.red,
    },
    {
      'title': 'Personal',
      'completed': 1,
      'total': 2,
      'color': Colors.green,
    },
    {
      'title': 'Shopping',
      'completed': 4,
      'total': 4,
      'color': Colors.orange,
    },
    {
      'title': 'Fitness',
      'completed': 4,
      'total': 4,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Category List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final auth = ref.read(authProvider);
              await auth.signOut();

              if (context.mounted) {
                showSuccessToast(context: context, text: '로그아웃 성공');
                context.push(routes.signIn);
              }
            },
          ),
        ],
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
                      return Column(
                        children: [
                          TaskCard(
                            title: task['title'],
                            completed: task['completed'],
                            total: task['total'],
                            color: task['color'],
                            onPressed: () {
                              context.push('/todo/${task['title']}');
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
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
          context.push(routes.todoCreate);
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

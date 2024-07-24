import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/constants/routes.dart';
import 'package:flutter_todo/providers/todo_list.dart';
import 'package:flutter_todo/screens/todo_list_screen.dart';
import 'package:flutter_todo/widgets/category_button.dart';
import 'package:go_router/go_router.dart';

import '../service/auth.dart';

class TodoCreateScreen extends ConsumerStatefulWidget {
  const TodoCreateScreen({super.key});

  @override
  TodoCreateScreenState createState() => TodoCreateScreenState();
}

class TodoCreateScreenState extends ConsumerState<TodoCreateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _checklistControllers = [];

  String? _selectedCategory;

  void _addChecklistItem() {
    setState(() {
      _checklistControllers.add(TextEditingController());
    });
  }

  void _removeChecklistItem(int index) {
    setState(() {
      _checklistControllers.removeAt(index);
    });
  }

  void _createTodo() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final category = _selectedCategory;
    final checklist = _checklistControllers.map((controller) {
      return {
        'label': controller.text,
        'isChecked': false,
        'icon': Icons.check,
      };
    }).toList();

    if (title.isNotEmpty && description.isNotEmpty && category != null) {
      ref.read(todoListProvider.notifier).addTodo(title);
      // 다른 필드를 저장하는 로직을 여기에 추가할 수 있습니다.

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const TodoListScreen()), // NewScreen은 이동할 새로운 화면
      );
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final supabaseService = AuthService();
              await supabaseService.signOut();

              if (context.mounted) {
                context.go(Routes.signIn);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Category',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton(
                      text: 'Work',
                      icon: Icons.work,
                      onTap: () => _selectCategory('Work'),
                      backgroundColor: Colors.red,
                      isSelected: _selectedCategory == 'Work',
                    ),
                    CategoryButton(
                      text: 'Personal',
                      icon: Icons.person,
                      onTap: () => _selectCategory('Personal'),
                      backgroundColor: Colors.green,
                      isSelected: _selectedCategory == 'Personal',
                    ),
                    CategoryButton(
                      text: 'Shopping',
                      icon: Icons.shopping_cart,
                      onTap: () => _selectCategory('Shopping'),
                      backgroundColor: Colors.orange,
                      isSelected: _selectedCategory == 'Shopping',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CategoryButton(
                      text: 'Fitness',
                      icon: Icons.fitness_center,
                      onTap: () => _selectCategory('Fitness'),
                      backgroundColor: Colors.purple,
                      isSelected: _selectedCategory == 'Fitness',
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Checklist',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed: _addChecklistItem,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._checklistControllers.asMap().entries.map((entry) {
              int index = entry.key;
              TextEditingController controller = entry.value;
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(labelText: 'Checklist item'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () => _removeChecklistItem(index),
                  ),
                ],
              );
            }),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _createTodo,
                child: const Text('Create Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

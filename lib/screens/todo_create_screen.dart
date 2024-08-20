import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_list.dart';
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/widgets/category_button.dart';
import 'package:flutter_todo/widgets/date_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;

class TodoCreateScreen extends ConsumerStatefulWidget {
  const TodoCreateScreen({super.key});

  @override
  TodoCreateScreenState createState() => TodoCreateScreenState();
}

class TodoCreateScreenState extends ConsumerState<TodoCreateScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<TextEditingController> _checklistControllers = [];

  final List<Map<String, dynamic>> categories = [
    {
      'text': 'Work',
      'icon': Icons.work,
      'backgroundColor': Colors.red,
    },
    {
      'text': 'Personal',
      'icon': Icons.person,
      'backgroundColor': Colors.green,
    },
    {
      'text': 'Shopping',
      'icon': Icons.shopping_cart,
      'backgroundColor': Colors.orange,
    },
    {
      'text': 'Fitness',
      'icon': Icons.fitness_center,
      'backgroundColor': Colors.purple,
    },
    // 추가 카테고리를 여기에 계속 추가할 수 있습니다.
  ];

  String? _selectedCategory;
  DateTime? _startDate;
  DateTime? _endDate;

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
    final startedAt = _startDate?.toIso8601String();
    final endedAt = _endDate?.toIso8601String();
    final checklist = _checklistControllers.map((controller) {
      return {
        'label': controller.text,
        'isChecked': false,
        'icon': Icons.check,
      };
    }).toList();

    if (title.isNotEmpty && description.isNotEmpty && category != null) {
      ref.read(todoListProvider.notifier).addTodo(
            title,
            description,
            category,
            startedAt,
            endedAt,
            checklist,
          );
      // 다른 필드를 저장하는 로직을 여기에 추가할 수 있습니다.

      context.push(routes.todoList);
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
                context.push(routes.signIn);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Due Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                DatePickerWidget(
                  initialDate: _startDate,
                  onDateSelected: (date) {
                    setState(() {
                      _startDate = date;
                    });
                  },
                  label: 'Start Date',
                ),
                DatePickerWidget(
                  initialDate: _endDate,
                  onDateSelected: (date) {
                    setState(() {
                      _endDate = date;
                    });
                  },
                  label: 'End Date',
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text('Select Category',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            const SizedBox(height: 20),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 350, // GridView의 높이를 명시적으로 지정
                    child: GridView.count(
                      crossAxisCount: 2, // 한 행에 두 개의 버튼을 배치
                      crossAxisSpacing: 16, // 버튼 간의 가로 간격
                      mainAxisSpacing: 16, // 버튼 간의 세로 간격
                      padding: const EdgeInsets.all(16), // 전체 그리드의 패딩
                      children: categories.map((category) {
                        return CategoryButton(
                          text: category['text'] as String,
                          icon: category['icon'] as IconData,
                          onTap: () => _selectCategory(category['text']),
                          backgroundColor: category['backgroundColor'] as Color,
                          isSelected: _selectedCategory == category['text'],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Due Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
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
            Column(
              children: _checklistControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Checklist item',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removeChecklistItem(index),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _createTodo,
                child: const Text('Create Todo'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

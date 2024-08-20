import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/models/category.dart';
import 'package:flutter_todo/providers/todo_list.dart';
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/widgets/category_button.dart';
import 'package:flutter_todo/widgets/date_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:flutter_todo/providers/category_list.dart';

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
  DateTime? _startDate;
  DateTime? _endDate;
  late Future<List<Category>?> _categoriesFuture;

  @override
  void initState() {
    super.initState();

    _categoriesFuture = ref.read(categoryListProvider.notifier).getCategories();
  }

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
                //context.push(routes.todoList);
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Category>?>(
        future: _categoriesFuture, // 이미 초기화된 Future 사용
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found'));
          } else {
            final categories = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  const SizedBox(height: 40),
                  const Text('Select Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 350,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: const EdgeInsets.all(16),
                      children: categories.map((category) {
                        return CategoryButton(
                          text: category.title,
                          icon: category.icon,
                          onTap: () => _selectCategory(category.id),
                          backgroundColor: category.color,
                          isSelected: _selectedCategory == category.id,
                        );
                      }).toList(),
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
                        decoration:
                            const InputDecoration(labelText: 'Description'),
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
                    children:
                        _checklistControllers.asMap().entries.map((entry) {
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
            );
          }
        },
      ),
    );
  }
}

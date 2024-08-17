import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'status_badge.dart';
import 'label_checkbox.dart';

import 'package:flutter_todo/providers/todo_list.dart';
import 'package:flutter_todo/models/todo.dart';

class BottomSheetContent extends ConsumerStatefulWidget {
  final String status;
  final String description;
  final List<Map<String, dynamic>> checklist;
  final String todoId;

  const BottomSheetContent({
    super.key,
    required this.status,
    required this.description,
    required this.checklist,
    required this.todoId,
  });

  @override
  BottomSheetContentState createState() => BottomSheetContentState();
}

class BottomSheetContentState extends ConsumerState<BottomSheetContent> {
  late List<Map<String, dynamic>> _checklist;

  @override
  void initState() {
    super.initState();
    _checklist = widget.checklist;
  }

  bool get _allChecked => _checklist.every((item) => item['completed'] == true);

  void _toggleCheckbox(int index, bool? value) {
    setState(() {
      _checklist[index]['completed'] = value ?? false;

      // Update checklist item using the function from todo_list
      ref.read(todoListProvider.notifier).updateCompleted(
            _checklist[index]['id'], // checklist item id
            _checklist[index]['completed'], // updated completed status
            false,
          );

      // Optionally update the whole checklist in the todo
      List<Checklist> updatedChecklist = _checklist.map((item) {
        return Checklist(
          id: item['id'],
          taskId: item['task_id'],
          title: item['title'],
          completed: item['completed'],
        );
      }).toList();

      ref.read(todoListProvider.notifier).setChecklist(
            widget.todoId,
            updatedChecklist,
          );
    });
  }

  void _completeTodo() {
    ref.read(todoListProvider.notifier).updateCompleted(
          widget.todoId,
          true,
          true, // isTask
        );
    //Navigator.pop(context); // Close the bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    final asyncTodos = ref.watch(todoListProvider);

    return asyncTodos.when(
      data: (todos) {
        final todo = todos.firstWhere((todo) => todo.id == widget.todoId);
        bool isCompleted = todo.completed;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          height: 350,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    StatusBadge(status: isCompleted ? 'completed' : 'ongoing'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Checklist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: _checklist.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> item = entry.value;
                    return LabelCheckbox(
                      label: item['title'],
                      isChecked: item['completed'],
                      onChanged: (bool? value) {
                        _toggleCheckbox(index, value);
                      },
                      direction: item['direction'] ?? Direction.left,
                      icon: item['icon'],
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _allChecked
                          ? _completeTodo
                          : null, // _completeTodo 호출
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                      ),
                      child: const Text(
                        'Complete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

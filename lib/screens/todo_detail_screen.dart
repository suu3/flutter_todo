import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_list.dart';

import 'package:flutter_todo/widgets/bottom_sheet.dart';
import 'package:flutter_todo/widgets/todo_card.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;

class TodoDetailScreen extends ConsumerStatefulWidget {
  final String todoId;
  final int number = 1;

  const TodoDetailScreen({super.key, required this.todoId});
  @override
  TodoDetailScreenState createState() => TodoDetailScreenState();
}

class TodoDetailScreenState extends ConsumerState<TodoDetailScreen> {
  Future<void> _removeTodo() async {
    final todoListNotifier = ref.read(todoListProvider.notifier);
    await todoListNotifier.removeTodo(widget.todoId);
    if (mounted) {
      context.push(routes.todoList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoListNotifier = ref.read(todoListProvider.notifier);
    final todo = todoListNotifier.getTodoById(widget.todoId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: _removeTodo,
              icon: const Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'card_${widget.number}',
              child: TodoCard(
                index: widget.number,
                title: todo!.title,
                date: todo.createdAt,
                category: "work",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BottomSheetContent(
                status: 'Ongoing',
                description: todo.description,
                checklist: todo.checklist.map((item) => item.toJson()).toList(),
                todoId: todo.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
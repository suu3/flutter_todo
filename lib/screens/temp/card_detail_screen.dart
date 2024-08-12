import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/widgets/temp/bottom_sheet.dart';
import 'package:flutter_todo/widgets/todo_card.dart';
import 'package:flutter_todo/providers/temp/todo_list.dart';

class CardDetailScreen extends ConsumerStatefulWidget {
  final String todoId;
  final int number = 1;

  const CardDetailScreen({super.key, required this.todoId});

  @override
  CardDetailScreenState createState() => CardDetailScreenState();
}

class CardDetailScreenState extends ConsumerState<CardDetailScreen> {
  Future<void> _removeTodo() async {
    final todoListNotifier = ref.read(todoListProvider.notifier);
    await todoListNotifier.removeTodo(widget.todoId);
    if (mounted) {
      Navigator.of(context).pop();
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
          onPressed: () => Navigator.of(context).pop(),
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
                date: todo.createdAt.toString(),
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

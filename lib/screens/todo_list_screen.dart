import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/providers/todo_list.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:flutter_todo/widgets/todo_card.dart';
import 'package:go_router/go_router.dart';

final List<Todo> dummyTodos = [
  Todo(
    id: '1',
    userId: 'user1',
    categoryId: 'work',
    title: 'Sample Todo 1',
    description: 'This is a sample todo item.',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    startedAt: DateTime.now(),
    endedAt: DateTime.now().add(const Duration(days: 1)),
    completed: false,
    checklist: [
      Checklist(
        id: 'check1',
        taskId: '1',
        title: 'Sample checklist item',
        completed: false,
      ),
    ],
  ),
  Todo(
    id: '2',
    userId: 'user2',
    categoryId: 'work',
    title: 'Sample Todo 2',
    description: 'Another sample todo item.',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    startedAt: DateTime.now(),
    endedAt: DateTime.now().add(const Duration(days: 2)),
    completed: false,
    checklist: [
      Checklist(
        id: 'check2',
        taskId: '2',
        title: 'Another checklist item',
        completed: false,
      ),
    ],
  ),
];

class TodoListScreen extends ConsumerWidget {
  final String? categoryId;

  const TodoListScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context.push(routes.todoCreate);
              },
              icon: const Icon(Icons.add_box_outlined)),
          IconButton(
              onPressed: () {
                context.push(routes.categorySelect);
              },
              icon: const Icon(Icons.category_outlined))
        ],
      ),
      body: todoList.when(
        data: (todos) {
          // 데이터가 없을 경우 dummyTodos 사용
          if (todos.isEmpty) {
            todos = dummyTodos;
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/todo/detail/$index');
                      },
                      child: Hero(
                        tag: 'card_$index',
                        child: TodoCard(
                          index: index,
                          title: todo.title,
                          date: todo.startedAt,
                          category: todo.categoryId,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_list.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:go_router/go_router.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

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
                context.push(routes.cardSelect);
              },
              icon: const Icon(Icons.category_outlined))
        ],
      ),
      body: todoList.when(
        data: (todos) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person_4,
                    size: 60,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 1.2,
                            height: 1),
                      ),
                      Text(
                        'Personal',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            height: 1.1),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        context.push(
                          '${routes.cardDetail}/${todo.id}',
                        );
                      },
                      child: ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

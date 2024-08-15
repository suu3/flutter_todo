import 'dart:async';
import 'package:flutter_todo/models/temp/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'todo_list.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    return await getTodos('ad5a4932-19e5-4f97-a4d8-29a6fa0e2c0b') ?? [];
  }

  Future<List<Todo>?> getTodos(String userId) async {
    final supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from('tasks')
          .select('*, checklist(*)')
          .eq('user_id', userId);

      if (response.isEmpty) {
        return null;
      }

      final todos = (response as List)
          .map((taskJson) => Todo.fromJson(taskJson))
          .toList();
      return todos;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Todo? getTodoById(String id) {
    return state.maybeWhen(
      data: (todos) {
        try {
          return todos.firstWhere((todo) => todo.id == id);
        } catch (e) {
          return null;
        }
      },
      orElse: () => null,
    );
  }

  Future<void> addTodo(
    String title,
    String description,
    String category,
    String? startedAt,
    String? endedAt,
    List<Map<String, dynamic>> checklist,
  ) async {
    final supabase = Supabase.instance.client;
    try {
      var userId = 'ad5a4932-19e5-4f97-a4d8-29a6fa0e2c0b';
      var categoryId = 'fb1778f3-838c-4c2c-8d27-454ef6993b13'; // category
      var createdAt = DateTime.now().toIso8601String();
      var updatedAt = DateTime.now().toIso8601String();
      var completed = false;

      final taskResponse = await supabase.from('tasks').insert({
        'user_id': userId,
        'category_id': categoryId,
        'title': title,
        'description': description,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'started_at': startedAt,
        'ended_at': endedAt,
        'completed': completed,
      }).select();

      if (taskResponse.isEmpty) {
        throw Exception('Failed to insert task');
      }

      final taskId = taskResponse.first['id'];
      final checklistItems = checklist
          .map((item) => {
                'task_id': taskId,
                'title': item['label'],
                'completed': item['isChecked'],
              })
          .toList();

      final checklistResponse =
          await supabase.from('checklist').insert(checklistItems).select();

      if (checklistResponse.isEmpty) {
        throw Exception('Failed to insert checklist');
      }

      final List<Checklist> newChecklist =
          (checklistResponse as List).map((item) {
        return Checklist(
          id: item['id'],
          taskId: item['task_id'],
          title: item['title'],
          completed: item['completed'],
        );
      }).toList();

      final newTodo = Todo(
          id: taskResponse.first['id'],
          userId: taskResponse.first['user_id'],
          categoryId: taskResponse.first['category_id'],
          title: taskResponse.first['title'],
          description: taskResponse.first['description'],
          createdAt: DateTime.parse(taskResponse.first['created_at']),
          updatedAt: DateTime.parse(taskResponse.first['updated_at']),
          startedAt: DateTime.parse(taskResponse.first['started_at']),
          endedAt: DateTime.parse(taskResponse.first['ended_at']),
          completed: taskResponse.first['completed'],
          checklist: newChecklist);

      state = AsyncData([...?state.value, newTodo]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCompleted(String id, bool completed, bool isTask) async {
    final supabase = Supabase.instance.client;
    try {
      if (isTask) {
        // task update
        final response = await supabase
            .from('tasks')
            .update({'completed': completed})
            .eq('id', id)
            .select();

        if (response.isEmpty) {
          return;
        }

        // Update state with the new completed value
        state = state.whenData((todos) {
          return todos.map((todo) {
            if (todo.id == id) {
              return todo.copyWith(completed: completed);
            }
            return todo;
          }).toList();
        });
      } else {
        // checklist update
        final response = await supabase
            .from('checklist')
            .update({'completed': completed})
            .eq('id', id)
            .select();

        if (response.isEmpty) {
          return;
        }

        // Update state with the new completed value for the checklist item
        state = state.whenData((todos) {
          return todos.map((todo) {
            return todo.copyWith(
              checklist: todo.checklist.map((item) {
                if (item.id == id) {
                  return item.copyWith(completed: completed);
                }
                return item;
              }).toList(),
            );
          }).toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeTodo(String id) async {
    final supabase = Supabase.instance.client;
    try {
      final response =
          await supabase.from('tasks').delete().eq('id', id).select();
      if (response.isEmpty) {
        return;
      }
      state = state.whenData((todos) {
        return todos.where((todo) => todo.id != id).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  void setChecklist(String todoId, List<Checklist> updatedChecklist) {
    state = state.whenData((todos) {
      return todos.map((todo) {
        if (todo.id == todoId) {
          return Todo(
            id: todo.id,
            userId: todo.userId,
            categoryId: todo.categoryId,
            title: todo.title,
            description: todo.description,
            createdAt: todo.createdAt,
            updatedAt: todo.updatedAt,
            startedAt: todo.startedAt,
            endedAt: todo.endedAt,
            completed: todo.completed,
            checklist: updatedChecklist,
          );
        }
        return todo;
      }).toList();
    });
  }
}

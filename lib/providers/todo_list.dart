import 'dart:async';
import 'package:flutter_todo/models/todo.dart';
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
      final response =
          await supabase.from('tasks').select().eq('user_id', userId);
      if (response.isEmpty) {
        return null;
      }
      final todos = (response as List)
          .map((todoData) => Todo(
                id: todoData['id'],
                userId: todoData['user_id'],
                categoryId: todoData['category_id'],
                title: todoData['title'],
                description: todoData['description'],
                createdAt: DateTime.parse(todoData['created_at']),
                updatedAt: DateTime.parse(todoData['updated_at'] as String? ??
                    DateTime.now().toIso8601String()),
                startedAt: DateTime.parse(todoData['started_at']),
                endedAt: DateTime.parse(todoData['ended_at']),
                completed: todoData['completed'],
              ))
          .toList();
      return todos;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addTodo(String title) async {
    final supabase = Supabase.instance.client;
    try {
      var userId = 'ad5a4932-19e5-4f97-a4d8-29a6fa0e2c0b';
      var categoryId = 'fb1778f3-838c-4c2c-8d27-454ef6993b13';
      var description = 'test description';
      var createdAt = DateTime.now().toIso8601String();
      var updatedAt = DateTime.now().toIso8601String();
      var startedAt = DateTime.now().toIso8601String();
      var endedAt =
          DateTime.now().add(const Duration(days: 7)).toIso8601String();
      var completed = false;

      final response = await supabase.from('tasks').insert({
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

      if (response.isEmpty) {
        return;
      }

      final newTodo = Todo(
        id: response.first['id'],
        userId: response.first['user_id'],
        categoryId: response.first['category_id'],
        title: response.first['title'],
        description: response.first['description'],
        createdAt: DateTime.parse(response.first['created_at']),
        updatedAt: DateTime.parse(response.first['updated_at']),
        startedAt: DateTime.parse(response.first['started_at']),
        endedAt: DateTime.parse(response.first['ended_at']),
        completed: response.first['completed'],
      );

      state = AsyncData([...?state.value, newTodo]);
    } catch (e) {
      print(e);
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

  Future<void> updateTodo(String id, {String? title, bool? completed}) async {
    final supabase = Supabase.instance.client;
    try {
      final updates = <String, dynamic>{};
      if (title != null) updates['title'] = title;
      if (completed != null) updates['completed'] = completed;

      final response =
          await supabase.from('tasks').update(updates).eq('id', id).select();
      if (response.isEmpty) {
        return;
      }

      state = state.whenData((todos) {
        return todos.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(
              title: title ?? todo.title,
              completed: completed ?? todo.completed,
            );
          }
          return todo;
        }).toList();
      });
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

  void toggleAll(bool completed) {
    state = state.whenData((todos) {
      return todos.map((todo) => todo.copyWith(completed: completed)).toList();
    });
  }

  void removeCompleted() {
    state = state.whenData((todos) {
      return todos.where((todo) => !todo.completed).toList();
    });
  }

  int get remainingTodos {
    return state.maybeWhen(
      data: (todos) => todos.where((todo) => !todo.completed).length,
      orElse: () => 0,
    );
  }

  bool get allComplete {
    return state.maybeWhen(
      data: (todos) => todos.every((todo) => todo.completed),
      orElse: () => false,
    );
  }
}

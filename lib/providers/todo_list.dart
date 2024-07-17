import 'package:flutter_todo/models/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() {
    return []; // 초기 상태는 빈 리스트
  }

  // Create: 새 Todo 항목 추가
  void addTodo(String title) {
    state = [...state, Todo(title: title)];
  }

  // Read: 특정 ID의 Todo 항목 조회
  Todo? getTodoById(String id) {
    return state.firstWhere((todo) => todo.id == id);
  }

  // Update: Todo 항목 업데이트
  void updateTodo(String id, {String? title, bool? completed}) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
          title: title ?? todo.title,
          completed: completed ?? todo.completed,
        );
      }
      return todo;
    }).toList();
  }

  // Delete: Todo 항목 삭제
  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  // 모든 Todo 항목 완료 상태 토글
  void toggleAll(bool completed) {
    state = state.map((todo) => todo.copyWith(completed: completed)).toList();
  }

  // 완료된 모든 Todo 항목 삭제
  void removeCompleted() {
    state = state.where((todo) => !todo.completed).toList();
  }

  // 남은 작업 수 계산
  int get remainingTodos => state.where((todo) => !todo.completed).length;

  // 모든 작업이 완료되었는지 확인
  bool get allComplete => state.every((todo) => todo.completed);
}

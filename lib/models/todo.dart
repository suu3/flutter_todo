import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String userId;
  final String categoryId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime startedAt;
  final DateTime endedAt;
  final bool completed;

  Todo({
    String? id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.startedAt,
    required this.endedAt,
    this.completed = false,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [
        id,
        userId,
        categoryId,
        title,
        description,
        createdAt,
        updatedAt,
        startedAt,
        endedAt,
        completed,
      ];

  Todo copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      completed: completed ?? this.completed,
    );
  }
}

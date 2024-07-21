import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool completed;

  Todo({required this.title, this.completed = false}) : id = const Uuid().v4();

  @override
  List<Object?> get props => [id];

  Todo copyWith({String? title, bool? completed}) {
    return Todo(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

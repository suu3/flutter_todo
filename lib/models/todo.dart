class Todo {
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
  final List<Checklist> checklist;

  Todo({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.startedAt,
    required this.endedAt,
    required this.completed,
    required this.checklist,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    var checklistJson = json['checklist'] as List? ?? [];
    List<Checklist> checklist =
        checklistJson.map((item) => Checklist.fromJson(item)).toList();

    return Todo(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(
          json['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'])
          : DateTime(0),
      endedAt: json['endedAt'] != null
          ? DateTime.parse(json['endedAt'])
          : DateTime(0),
      completed: json['completed'] as bool? ?? false,
      checklist: checklist,
    );
  }

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
    List<Checklist>? checklist,
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
      checklist: checklist ?? this.checklist,
    );
  }
}

class Checklist {
  final String id;
  final String taskId;
  final String title;
  final bool completed;

  Checklist({
    required this.id,
    required this.taskId,
    required this.title,
    required this.completed,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'] as String? ?? '',
      taskId: json['task_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      completed: json['completed'] as bool? ?? false,
    );
  }

  Checklist copyWith({
    String? id,
    String? taskId,
    String? title,
    bool? completed,
  }) {
    return Checklist(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'title': title,
      'completed': completed,
    };
  }
}

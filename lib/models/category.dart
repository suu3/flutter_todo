class Category {
  final String id;
  final String userId;
  final String title;
  final String color;

  Category({
    required this.id,
    required this.userId,
    required this.title,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'] as String? ?? '',
        userId: json['userId'] as String? ?? '',
        title: json['title'] as String? ?? '',
        color: json['color'] as String? ?? '');
  }

  Category copyWith(
      {String? id, String? userId, String? title, String? color}) {
    return Category(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        color: color ?? this.color);
  }
}

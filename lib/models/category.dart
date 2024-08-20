import 'package:flutter/material.dart';

class Category {
  final String id;
  final String userId;
  final String title;
  final Color color;
  final IconData icon;

  Category({
    required this.id,
    required this.userId,
    required this.title,
    required this.color,
    required this.icon,
  });

  // fromJson 생성자에서 문자열을 아이콘과 색상으로 변환
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      color: getColorFromString(json['color'] as String? ?? 'grey'),
      icon: getIconDataFromString(json['icon'] as String? ?? 'help'),
    );
  }

  // copyWith 메서드에서 문자열이 주어질 경우 이를 변환
  Category copyWith({
    String? id,
    String? userId,
    String? title,
    Color? color,
    IconData? icon,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  // 아이콘 문자열을 IconData로 변환
  static IconData getIconDataFromString(String iconName) {
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'person':
        return Icons.person;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'fitness_center':
        return Icons.fitness_center;
      // 필요한 다른 아이콘들을 여기에 추가
      default:
        return Icons.help; // 기본 아이콘 (매핑되지 않는 경우)
    }
  }

  // 색상 문자열을 Color로 변환
  static Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      // 필요한 다른 색상들을 여기에 추가
      default:
        return Colors.grey; // 기본 색상 (매핑되지 않는 경우)
    }
  }
}

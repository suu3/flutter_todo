import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/category_button.dart';
import 'package:go_router/go_router.dart';

class CategoryButtonList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryButtonList({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CategoryButton(
              text: category['text'],
              icon: category['icon'],
              onTap: () {
                final categoryId = category['text'] as String;
                context.push('/todo/$categoryId');
              },
              backgroundColor: category['backgroundColor'] as Color,
              isSelected: false,
              tasks: category.containsKey('tasks') ? category['tasks'] : null,
              showAddButton: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}

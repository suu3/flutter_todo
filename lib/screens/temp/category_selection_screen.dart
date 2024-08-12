import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/todo_card.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  final List<Map<String, String>> categories = const [
    {'title': 'Work', 'date': '2024-07-22', 'category': 'work'},
    {'title': 'Personal', 'date': '2024-07-22', 'category': 'personal'},
    {'title': 'Study', 'date': '2024-07-22', 'category': 'study'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Select Category'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return TodoCard(
            index: index + 1,
            title: category['title']!,
            date: category['date']!,
            category: category['category']!,
          );
        },
      ),
    );
  }
}

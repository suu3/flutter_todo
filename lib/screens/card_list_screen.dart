import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart';
import 'package:flutter_todo/widgets/todo_card.dart';
import 'package:go_router/go_router.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Card List',
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        backgroundColor:
            Theme.of(context).colorScheme.primary, // 테마의 primary 색상 사용
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, 1, 'Enterprise Resource', '20 Apr 2030', 'work'),
          _buildCard(context, 2, 'Web Development', '12 May 2030', 'personal'),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index, String title, String date,
      String category) {
    // 임시 체크리스트 데이터 정의
    final List<Map<String, dynamic>> checklist = [
      {
        'label': 'Task 1 for $title',
        'isChecked': false,
        'icon': Icons.check,
      },
      {
        'label': 'Task 2 for $title',
        'isChecked': true,
        'icon': Icons.check,
      },
    ];

    return GestureDetector(
      onTap: () {
        context.push(
          '$cardDetail/$index',
          extra: {
            'title': title,
            'date': date,
            'category': category,
            'checklist': checklist,
          },
        );
      },
      child: Hero(
        tag: 'card_$index',
        child: TodoCard(
          index: index,
          title: title,
          date: date,
          category: category,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/bottom_sheet.dart';
import 'package:flutter_todo/widgets/todo_card.dart';
import 'package:go_router/go_router.dart';

class CardDetailScreen extends StatelessWidget {
  final int number;
  final String title;
  final String date;
  final String category;

  final List<Map<String, dynamic>> checklist;

  const CardDetailScreen({
    super.key,
    required this.number,
    required this.title,
    required this.date,
    required this.category,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'card_$number',
              child: TodoCard(
                index: number,
                title: title,
                date: date,
                category: category,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BottomSheetContent(
                status: 'Ongoing',
                description:
                    'Cooperate with designers to complete the front-end development work. Ensure the normal promotion of the project.',
                checklist: checklist,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

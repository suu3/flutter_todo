import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Date formatting을 위해 intl 패키지를 사용

const double borderRadiusValue = 30.0;

class TodoCard extends StatelessWidget {
  final int index;
  final String title;
  final DateTime date; // DateTime 타입으로 변경
  final String category;

  const TodoCard({
    super.key,
    required this.index,
    required this.title,
    required this.date, // DateTime 타입
    required this.category,
  });

  // 날짜를 원하는 형식으로 포맷팅
  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date); // '20 Apr 2030' 형식으로 변환
  }

  List<Color> _getGradientColors(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return [Colors.blue.shade200, Colors.blue.shade500];
      case 'personal':
        return [Colors.green.shade200, Colors.green.shade500];
      case 'study':
        return [Colors.purple.shade200, Colors.purple.shade500];
      default:
        return [Colors.yellow.shade200, Colors.yellow.shade500];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(category),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$index',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 90,
                  ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 48,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _formatDate(date), // DateTime을 형식화된 문자열로 출력
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w100,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

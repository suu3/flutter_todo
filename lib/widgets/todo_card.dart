import 'package:flutter/material.dart';

const double borderRadiusValue = 30.0;

class TodoCard extends StatelessWidget {
  final int index;
  final String title;
  final String date;
  final String category;

  const TodoCard({
    super.key,
    required this.index,
    required this.title,
    required this.date,
    required this.category,
  });

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
          mainAxisSize: MainAxisSize.min, // 추가된 부분
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
              // 수정된 부분
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
                  date,
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

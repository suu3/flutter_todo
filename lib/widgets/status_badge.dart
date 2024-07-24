import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBackgroundColor;

    switch (status.toLowerCase()) {
      case 'ongoing':
        statusColor = Colors.green;
        statusBackgroundColor = Colors.green.shade100;
        break;
      case 'completed':
        statusColor = Colors.blue;
        statusBackgroundColor = Colors.blue.shade100;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusBackgroundColor = Colors.orange.shade100;
        break;
      default:
        statusColor = Colors.grey;
        statusBackgroundColor = Colors.grey.shade100;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

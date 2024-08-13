import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateSelected;
  final String label;

  const DatePickerWidget({
    super.key,
    this.initialDate,
    required this.onDateSelected,
    required this.label,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        TextButton(
          onPressed: () => _selectDate(context),
          child: Text(
            initialDate != null
                ? initialDate!.toLocal().toString().split(' ')[0]
                : 'Select date',
          ),
        ),
      ],
    );
  }
}

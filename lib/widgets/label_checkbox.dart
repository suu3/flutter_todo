import 'package:flutter/material.dart';

enum Direction { left, right, center }

class LabelCheckbox extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final Direction? direction;

  const LabelCheckbox({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onChanged,
    this.direction = Direction.left,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment alignment;

    switch (direction) {
      case Direction.right:
        alignment = MainAxisAlignment.end;
        break;
      case Direction.center:
        alignment = MainAxisAlignment.center;
        break;
      case Direction.left:
      default:
        alignment = MainAxisAlignment.start;
        break;
    }

    return Row(
      mainAxisAlignment: alignment,
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
        ),
        if (icon != null)
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Icon(icon, color: isChecked ? Colors.grey : Colors.black),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: isChecked ? Colors.grey : Colors.black,
                    ),
                  ),
                ],
              ),
              if (isChecked)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        if (icon == null)
          Text(
            label,
            style: TextStyle(
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: isChecked ? Colors.grey : Colors.black,
                fontSize: 20),
          ),
      ],
    );
  }
}

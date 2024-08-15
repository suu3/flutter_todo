import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final bool isSelected;
  final int? tasks; // 선택형 변수로 변경
  final bool? showAddButton; // 옵셔널 플러스 버튼

  const CategoryButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.isSelected,
    this.tasks, // 선택형 변수로 변경
    this.showAddButton, // 옵셔널 플러스 버튼
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 50,
        minHeight: 40,
        maxWidth: 130,
        maxHeight: 130,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: isSelected ? Colors.black12 : backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: isSelected
                  ? const BorderSide(color: Colors.yellow, width: 2)
                  : BorderSide.none,
            ),
            elevation: isSelected ? 10 : 5,
            shadowColor: isSelected ? Colors.yellowAccent : Colors.black54,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (tasks != null && tasks! > 0)
                        Text(
                          '$tasks tasks',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      if (showAddButton == true)
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

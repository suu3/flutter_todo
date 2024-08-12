import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'status_badge.dart'; // status_badge.dart 파일을 임포트하세요
import 'label_checkbox.dart'; // label_checkbox.dart 파일을 임포트하세요

class BottomSheetContent extends StatefulWidget {
  final String status;
  final String description;
  final List<Map<String, dynamic>> checklist;

  const BottomSheetContent({
    super.key,
    required this.status,
    required this.description,
    required this.checklist,
  });

  @override
  BottomSheetContentState createState() => BottomSheetContentState();
}

class BottomSheetContentState extends State<BottomSheetContent> {
  late List<Map<String, dynamic>> _checklist;

  @override
  void initState() {
    super.initState();
    _checklist = widget.checklist;
  }

  bool get _allChecked => _checklist.every((item) => item['isChecked'] == true);

  void _toggleCheckbox(int index, bool? value) {
    setState(() {
      _checklist[index]['isChecked'] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      height: 350,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                StatusBadge(status: widget.status),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Checklist',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: _checklist.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value;
                return LabelCheckbox(
                  label: item['label'],
                  isChecked: item['isChecked'],
                  onChanged: (bool? value) {
                    _toggleCheckbox(index, value);
                  },
                  direction: item['direction'] ?? Direction.left,
                  icon: item['icon'],
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: ElevatedButton(
                  onPressed: _allChecked
                      ? () {
                          context.pop();
                        }
                      : null, // 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                  ),
                  child: const Text(
                    'Complete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/category_button.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Design',
      'tasks': 5,
      'category': 'design',
      'color': '0xFFFFA07A',
      'icon': Icons.design_services
    },
    {
      'title': 'Learning',
      'tasks': 3,
      'category': 'learning',
      'color': '0xFF87CEFA',
      'icon': Icons.school
    },
    {
      'title': 'Meeting',
      'tasks': 1,
      'category': 'meeting',
      'color': '0xFFFFD700',
      'icon': Icons.meeting_room
    },
  ];

  final List<Map<String, dynamic>> todayTasks = const [
    {'title': 'Sketching', 'completed': 2, 'total': 4, 'color': Colors.green},
    {
      'title': 'Wireframing',
      'completed': 1,
      'total': 2,
      'color': Colors.purple
    },
    {
      'title': 'Visual Design',
      'completed': 4,
      'total': 4,
      'color': Colors.orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Category List'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return _buildCategoryButton(category);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Today's Task",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: todayTasks.map((task) {
                      return _buildTaskCard(task);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: (int index) {
          // Handle tap events here
        },
      ),
    );
  }

  Widget _buildCategoryButton(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CategoryButton(
          text: category['title'],
          icon: category['icon'],
          onTap: () {},
          backgroundColor: Color(int.parse(category['color'])),
          isSelected: false, // Adjust this value as necessary
          tasks: category.containsKey('tasks') ? category['tasks'] : null,
          showAddButton: true),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: task['color'].withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task['title'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${task['completed']} Completed',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: task['color'],
            child: Text('${task['total']}'),
          ),
        ],
      ),
    );
  }
}

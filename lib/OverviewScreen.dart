import 'package:flutter/material.dart';
import 'Student.dart';

class OverviewScreen extends StatelessWidget {
  final List<Student> students;
  final List<String> classes;

  const OverviewScreen({
    super.key,
    required this.students,
    required this.classes,
  });

  int countStudents(String className) {
    return students.where((s) => s.subject == className).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("School Manager")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.blue.shade100,
                    child: Column(
                      children: [
                        Text("${students.length}", style: const TextStyle(fontSize: 24)),
                        const Text("Students"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green.shade100,
                    child: Column(
                      children: [
                        Text("${classes.length}", style: const TextStyle(fontSize: 24)),
                        const Text("Classes"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: classes.map((c) {
                  final count = countStudents(c);
                  return ListTile(
                    title: Text(c),
                    trailing: Text("$count"),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
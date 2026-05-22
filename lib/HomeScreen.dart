import 'package:flutter/material.dart';

import 'Student.dart';

class HomeScreen extends StatefulWidget {
  final List<Student> students;
  final List<String> classes;
  final VoidCallback onUpdate;

  const HomeScreen({
    super.key,
    required this.students,
    required this.classes,
    required this.onUpdate,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  String selectedClass = "Select class";

  void addStudent() {
    if (nameController.text.trim().isEmpty) return;
    if (selectedClass == "Select class") return;

    setState(() {
      widget.students.add(
        Student(
          name: nameController.text,
          subject: selectedClass,
        ),
      );
      nameController.clear();
      selectedClass = "Select class";
    });

    widget.onUpdate();
  }

  void deleteStudent(int index) {
    setState(() {
      widget.students.removeAt(index);
    });

    widget.onUpdate();
  }

  void clearAll() {
    setState(() {
      widget.students.clear();
    });

    widget.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final displayedStudents = widget.students.length > 2
        ? widget.students.sublist(widget.students.length - 2)
        : widget.students;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("School Manager"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Student name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedClass,
                      items: ["Select class", ...widget.classes]
                          .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: addStudent,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                            ),
                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: clearAll,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Clear"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: displayedStudents.isEmpty
                  ? const Center(child: Text("No students yet"))
                  : ListView.builder(
                itemCount: displayedStudents.length,
                itemBuilder: (context, index) {
                  final student = displayedStudents[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(student.name),
                      subtitle: Text(student.subject),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final realIndex =
                          widget.students.indexOf(student);
                          deleteStudent(realIndex);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ClassesScreen extends StatefulWidget {
  final List<String> classes;
  final VoidCallback onUpdate;

  const ClassesScreen({
    super.key,
    required this.classes,
    required this.onUpdate,
  });

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final TextEditingController controller = TextEditingController();

  void addClass() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      widget.classes.add(controller.text);
      controller.clear();
      widget.onUpdate();
    });
  }

  void deleteClass(int index) {
    setState(() {
      widget.classes.removeAt(index);
      widget.onUpdate();
    });
  }

  void clearAll() {
    setState(() {
      widget.classes.clear();
      widget.onUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("School Manager")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Class name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addClass,
                    child: const Text("Add"),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: clearAll,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Clear"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.classes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.classes[index]),
                    subtitle: const Text("0 students"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteClass(index),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
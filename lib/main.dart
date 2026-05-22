import 'package:flutter/material.dart';
import 'ClassesScreen.dart';
import 'HomeScreen.dart';
import 'OverviewScreen.dart';
import 'Student.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Student> students = [];
  List<String> classes = ["Math", "Science"];

  int currentIndex = 0;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final screens = [
      HomeScreen(
        students: students,
        classes: classes,
        onUpdate: refresh,
      ),
      ClassesScreen(
        classes: classes,
        onUpdate: refresh,
      ),
      OverviewScreen(
        students: students,
        classes: classes,
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Students",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Classes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Overview",
            ),
          ],
        ),
      ),
    );
  }
}
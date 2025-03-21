import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/task_model.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // เริ่มต้นใช้งาน Hive Database ใน Flutter
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks'); // เปิด Box สำหรับเก็บ Task

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      home: const HomeScreen(), // ใช้ HomeScreen เป็นหน้าจอหลัก
    );
  }
}

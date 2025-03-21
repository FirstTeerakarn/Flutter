import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task_model.dart';
import 'calendar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Task> _taskBox;
  List<Task> _tasks = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // เข้าถึง Box ที่ชื่อว่า tasks ซึ่งเก็บข้อมูลของ Task โดยตรง
    _taskBox = Hive.box<Task>('tasks');
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _tasks = _taskBox.values.toList();
    });
  }

  void _addTask(String title, DateTime date) {
    final newTask = Task(title: title, date: date, isCompleted: false);
    _taskBox.add(newTask);
    setState(() {
      _tasks.add(newTask);
    });
  }

  void _deleteTask(int index) {
    _taskBox.deleteAt(index);
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _toggleTask(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _taskBox.putAt(index, _tasks[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        backgroundColor: const Color.fromARGB(255, 200, 151, 255),
      ),
      body:
          _tasks.isEmpty
              ? const Center(child: Text("No tasks available"))
              : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index]; //ข้อมูลของ Task ที่แสดงในแต่ละแถว
                  String formattedDate =
                      task.date != null
                          ? DateFormat('dd/MM/yyyy').format(task.date!)
                          : "No date"; // แปลงDateTime เป็น วัน/เดือน/ปี

                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text("Date: $formattedDate"),
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => _toggleTask(index),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index),
                    ),
                  );
                },
              ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "calendar",
            onPressed: () => _showCalendarDialog(context),
            child: const Icon(Icons.calendar_today),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "add_task",
            onPressed: () => _showAddTaskDialog(context),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  // Popup: เพิ่ม Task
  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController(); // สร้างตัวควบคุม TextField
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('New Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Task name'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2025),
                        lastDate: DateTime(2035),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      "Select Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}",
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      _addTask(
                        controller.text,
                        selectedDate,
                      ); //function _addTask
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Popup: ปฏิทินแสดง Task ตามวันที่เลือก
  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Select Date', style: TextStyle(fontSize: 18)),
              ),
              TableCalendar(
                firstDay: DateTime.utc(2025, 01, 01),
                lastDay: DateTime.utc(2035, 12, 31),
                focusedDay: DateTime.now(),
                availableCalendarFormats: {CalendarFormat.month: 'Month'},
                onDaySelected: (selectedDay, focusedDay) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarScreen(selectedDay),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

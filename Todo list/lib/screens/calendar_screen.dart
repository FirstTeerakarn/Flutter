import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class CalendarScreen extends StatefulWidget {
  final DateTime selectedDate;

  const CalendarScreen(this.selectedDate, {super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Box<Task> _taskBox;
  List<Task> _tasksForSelectedDay = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _taskBox = Hive.box<Task>('tasks');
    _loadTasksForSelectedDay();
  }

  Future<void> _loadTasksForSelectedDay() async {
    setState(() {
      _tasksForSelectedDay =
          _taskBox.values
              .where(
                (task) =>
                    task.date?.year == widget.selectedDate.year &&
                    task.date?.month == widget.selectedDate.month &&
                    task.date?.day == widget.selectedDate.day,
              )
              .toList();
    });
  }

  void _toggleTask(int index) {
    _tasksForSelectedDay[index].isCompleted =
        !_tasksForSelectedDay[index].isCompleted;
    _taskBox.putAt(index, _tasksForSelectedDay[index]);
    setState(() {});
  }

  void _deleteTask(int index) {
    _taskBox.deleteAt(index);
    setState(() {
      _tasksForSelectedDay.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks for ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)}",
        ),
      ),
      body:
          _tasksForSelectedDay.isEmpty
              ? const Center(child: Text("No tasks for this day"))
              : ListView.builder(
                itemCount: _tasksForSelectedDay.length,
                itemBuilder: (context, index) {
                  final task = _tasksForSelectedDay[index];
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
    );
  }
}

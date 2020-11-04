import 'package:flutter/material.dart';
import 'package:ma_todo/model/priority.dart';

// Task Model
class Task extends ChangeNotifier {
  String id;
  String title;
  String description;
  bool isDone;
  Priority priority;
  DateTime dueDate;

  // Constructor
  Task(String id, String title, String description, bool status,
      DateTime dueDate, int priority) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.isDone = status;
    this.dueDate = dueDate;
    this.priority = mapToPriority(priority);
  }

  Priority mapToPriority(int prio) {
    if (prio == 0) return Priority.Low;
    if (prio == 1) return Priority.Medium;
    if (prio == 2) return Priority.High;
    return Priority.Low;
  }

  // update Task & notify listeners
  void updateTask(Task updateTask) {
    this.id = updateTask.id;
    this.title = updateTask.title;
    this.description = updateTask.description;
    this.isDone = updateTask.isDone;
    this.dueDate = updateTask.dueDate;
    this.priority = updateTask.priority;

    notifyListeners();
  }
}

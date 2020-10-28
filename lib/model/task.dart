import 'package:flutter/material.dart';

class Task extends ChangeNotifier {
  String id;
  String title;
  String description;
  bool isDone;
  DateTime dueDate;

  Task(String id, String title, String description, bool status,
      DateTime dueDate) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.isDone = status;
    this.dueDate = dueDate;
  }

  void updateTask(Task updateTask) {
    this.id = updateTask.id;
    this.title = updateTask.title;
    this.description = updateTask.description;
    this.isDone = updateTask.isDone;
    this.dueDate = updateTask.dueDate;

    notifyListeners();
  }
}

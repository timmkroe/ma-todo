import 'package:flutter/material.dart';

class Task extends ChangeNotifier {
  String id;
  String Title;
  String Description;
  bool isDone;
  DateTime dueDate;
  
  Task(String id, String title, String description, bool status, DateTime dueDate){
    this.id = id;
    this.Title = title;
    this.Description = description;
    this.isDone = status;
    this.dueDate = dueDate;
  }
  
  Future updateTask(Task updateTask) {
    this.id = updateTask.id;
    this.Title = updateTask.Title;
    this.Description = updateTask.Description;
    this.isDone = updateTask.isDone;
    this.dueDate = updateTask.dueDate;
    
    notifyListeners();
  }
}
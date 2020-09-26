import 'package:flutter/cupertino.dart';

class Task extends ChangeNotifier {
  String Title;
  String Description;
  bool Status;
  
  Task(String title, String description, bool status){
    this.Title = title;
    this.Description = description;
    this.Status = status;
  }
  
  Future updateTask(Task updateTask) {
    this.Title = updateTask.Title;
    this.Description = updateTask.Description;
    this.Status = updateTask.Status;
    
    notifyListeners();
  }
}
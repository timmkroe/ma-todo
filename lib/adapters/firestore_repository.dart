import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ma_todo/model/task.dart';

class FireStoreRepository {

  final CollectionReference todoCollection =
  FirebaseFirestore.instance.collection("todo");
  
  // Get All
  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = new List<Task>();
    
    await todoCollection.get().then((value) => {
      value.docs.forEach((doc) {
        Task tmp = new Task(doc.get("title"), doc.get("description"),
            doc.get("status"));
        tasks.add(tmp);
        print(doc.data());
      })
    });
    
    return tasks;
  }
  
  // Insert new
  Future<void> newTask(Task task) async {
    await todoCollection.add({
      'title': task.Title,
      'description': task.Description,
      'status': false
    });
  }
  // Update / Done
  Future<void> updateTask(String id, Task task) async {
    await todoCollection.doc(id).update({
      'title': task.Title,
      'description': task.Description,
      'status': task.Status
    });
  }
  
}
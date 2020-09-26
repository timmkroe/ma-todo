import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ma_todo/model/task.dart';

class FireStoreRepository {

  final CollectionReference todoCollection =
  FirebaseFirestore.instance.collection("todo");
  
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
  
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:ma_todo/model/task.dart';

class FireStoreRepository {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todo");

  // Get All
  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = new List<Task>();

    await todoCollection.get().then((value) => {
          value.docs.forEach((doc) {
            DateTime date = (doc.get("dueDate") as Timestamp).toDate();

            Task tmp = Task(doc.id, doc.get("title"), doc.get("description"),
                doc.get("isDone"), date);
            tasks.add(tmp);
            print(tmp.dueDate);
          })
        });
    tasks.sort((a, b) {
      return a.dueDate.compareTo(b.dueDate);
    });

    return tasks;
  }

  // Insert new
  Future<void> newTask(Task task) async {
    await todoCollection.add({
      'title': task.Title,
      'description': task.Description,
      'isDone': false,
      'dueDate': task.dueDate
    });
  }

  // Set a Task to Done
  Future<void> doneTask(String id) async {
    await todoCollection.doc(id).update({'isDone': true});
  }

  // Update
  Future<void> updateTask(String id, Task task) async {
    await todoCollection.doc(id).update({
      'title': task.Title,
      'description': task.Description,
      'isDone': task.isDone,
      'dueDate': task.dueDate
    });
  }

  // Delete
  Future<void> deletetask(String id) async {
    await todoCollection.doc(id).delete();
  }
}

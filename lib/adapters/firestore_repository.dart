import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ma_todo/model/task.dart';

// Firebase FireStore Repository
// Handles connections & database transactions
class FireStoreRepository {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todo");

  // Get All Tasks from Firebase
  Future<List<Task>> getAllTasks() async {
    List<Task> tasks = new List<Task>();

    // get all tasks
    await todoCollection.get().then((value) => {
          // iterate through collection of all todos
          value.docs.forEach((doc) {
            // convert timestamp to datetime
            DateTime date = (doc.get("dueDate") as Timestamp).toDate();

            // tmp task to add to list
            Task tmp = Task(doc.id, doc.get("title"), doc.get("description"),
                doc.get("isDone"), date, doc.get("priority") ?? 0);
            tasks.add(tmp);
          })
        });

    // sort by due date
    tasks.sort((a, b) {
      return a.dueDate.compareTo(b.dueDate);
    });

    return tasks;
  }

  // create new task
  Future<void> newTask(Task task) async {
    await todoCollection.add({
      'title': task.title,
      'description': task.description,
      'isDone': false,
      'dueDate': task.dueDate,
      'priority': task.priority.index
    });
  }

  // update a Task to Done
  Future<void> doneTask(String id) async {
    await todoCollection.doc(id).update({'isDone': true});
  }

  // update task in the database (currently not in use)
  Future<void> updateTask(String id, Task task) async {
    await todoCollection.doc(id).update({
      'title': task.title,
      'description': task.description,
      'isDone': task.isDone,
      'dueDate': task.dueDate,
      'priority': task.priority
    });
  }

  // delete task
  Future<void> deletetask(String id) async {
    await todoCollection.doc(id).delete();
  }
}

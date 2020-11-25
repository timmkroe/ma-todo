import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_todo/adapters/firestore_repository.dart';
import 'package:ma_todo/model/task.dart';
import 'package:ma_todo/shared/app_colors.dart';
import 'package:ma_todo/widgets/create_task_form.dart';
import 'package:ma_todo/widgets/list_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FireStoreRepository repository = FireStoreRepository();
  bool _isLoading = true;
  List<Task> tasks;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();

  // Date
  DateTime selectedDate;

  @override
  void initState() {
    _fetchTasks();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  // Pull to refresh method to get latest tasks
  _fetchTasks() async {
    try {
      setState(() {
        _isLoading = true;
      });

      dynamic tmptasks = await repository.getAllTasks();

      setState(() {
        tasks = tmptasks;
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.loop,
                size: 100,
                color: Colors.black38,
              ),
              Text('Loading...')
            ],
          ),
        ),
      );
    } else if (!_isLoading && tasks != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
        ),
        backgroundColor: AppColors.backgroundColor(),
        body: Container(
          child: Center(
            child: RefreshIndicator(
              onRefresh: () {
                _fetchTasks();
                return null; // nicht optimal
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListItem(task: tasks[index]);
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return CreateTaskForm();
              },
            );
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.done_all,
                size: 100,
                color: Colors.black38,
              ),
              Text('All done!')
            ],
          ),
        ),
      );
    }
  }
}

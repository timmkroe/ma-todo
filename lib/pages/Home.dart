import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ma_todo/adapters/firestore_repository.dart';
import 'package:ma_todo/model/priority.dart';
import 'package:ma_todo/model/task.dart';
import 'package:ma_todo/shared/app_colors.dart';
import 'package:ma_todo/widgets/list_item.dart';
import 'package:vibration/vibration.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  FireStoreRepository repository = FireStoreRepository();
  bool _isLoading = true;
  List<Task> tasks;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  Priority _priority = Priority.Low;

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
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'New Task',
                        style: TextStyle(
                            color: AppColors.primaryTextColor(),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              controller: titleController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Bitte einen Titel eingeben!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              controller: descriptionController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Bitte eine Beschreibung eingeben!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: dueDateController,
                              decoration: InputDecoration(
                                  labelText: 'Due Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              readOnly: true,
                              onTap: () => {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year),
                                  lastDate: DateTime(2025),
                                ).then((value) => {
                                      dueDateController.text =
                                          DateFormat.yMd().format(value),
                                      setState(() {
                                        selectedDate = value;
                                      })
                                    })
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Bitte ein Datum auswählen!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all()),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Priority>(
                                    isExpanded: true,
                                    value: _priority,
                                    items: [
                                      DropdownMenuItem(
                                          child: Text('Low'),
                                          value: Priority.Low),
                                      DropdownMenuItem(
                                          child: Text('Medium'),
                                          value: Priority.Medium),
                                      DropdownMenuItem(
                                          child: Text('High'),
                                          value: Priority.High)
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _priority = value;
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    Task task = new Task(
                                        null,
                                        titleController.text,
                                        descriptionController.text,
                                        false,
                                        selectedDate,
                                        _priority.index);
                                    repository.newTask(task);
                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate(
                                          duration: 200, intensities: [100]);
                                    }
                                    _fetchTasks();
                                    titleController.text = "";
                                    descriptionController.text = "";
                                    dueDateController.text = "";
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(fontSize: 25),
                                ),
                                color: AppColors.primaryColor(),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom),
                          ],
                        ),
                      )
                    ],
                  ),
                );
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

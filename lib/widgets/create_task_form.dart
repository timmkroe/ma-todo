
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ma_todo/adapters/firestore_repository.dart';
import 'package:ma_todo/model/priority.dart';
import 'package:ma_todo/model/task.dart';
import 'package:ma_todo/shared/app_colors.dart';
import 'package:vibration/vibration.dart';

class CreateTaskForm extends StatefulWidget {
  @override
  _CreateTaskFormState createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {

  FireStoreRepository repository = FireStoreRepository();

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();

  DateTime selectedDate;
  Priority _priority = Priority.Low;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        // TODO: fetch Tasks here!
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
  }
}
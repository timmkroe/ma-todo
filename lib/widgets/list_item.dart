import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ma_todo/adapters/firestore_repository.dart';
import 'package:ma_todo/model/priority.dart';
import 'package:ma_todo/model/task.dart';
import 'package:ma_todo/shared/app_colors.dart';

// Item widget for the list on homescreen
class ListItem extends StatelessWidget {
  ListItem({Key key, this.task}) : super(key: key);

  final Task task;
  FireStoreRepository repository = new FireStoreRepository();

  @override
  Widget build(BuildContext context) {
    var colorStatus = Colors.white;

    if (task.priority == Priority.High)
      colorStatus = AppColors.highPriorityColor();
    if (task.priority == Priority.Medium)
      colorStatus = AppColors.mediumPriorityColor(); // rgb(241, 196, 15)

    return Center(
      child: GestureDetector(
        onTap: () {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                '${task.title}',
                                style: TextStyle(
                                    color: AppColors.primaryTextColor(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${DateFormat("dd.MM.yyyy").format(task.dueDate)}',
                          style: TextStyle(
                              color: task.dueDate.isBefore(DateTime.now())
                                  ? AppColors.redAccentcolor()
                                  : AppColors.primaryTextColor()),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Chip(
                      avatar: CircleAvatar(
                        backgroundColor: task.priority.color,
                        child: Text(task.priority.name[0]),
                      ),
                      label: Text('${task.priority.name} Priority'),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: AppColors.primaryTextColor(),
                              fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(text: '${task.description}')
                          ]),
                    ),
                    SizedBox(height: 30),
                    !task.isDone
                        ? SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                repository.doneTask(task.id);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(fontSize: 25),
                              ),
                              color: AppColors.primaryColor(),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                repository.deletetask(task.id);
                                Navigator.pop(context);
                              },
                              child: Text('Delete',
                                  style: TextStyle(fontSize: 25)),
                              color: AppColors.highPriorityColor(),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        },
        child: Card(
          elevation: 0.2,
          color: task.isDone ? AppColors.doneTaskColor() : colorStatus,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Text('${task.title}',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryTextColor()))
                        ],
                      ),
                    ),
                    Text(
                      '${DateFormat("dd.MM.yyyy").format(task.dueDate)}',
                      style: TextStyle(
                          color: task.dueDate.isBefore(DateTime.now())
                              ? task.isDone
                                  ? AppColors.primaryTextColor()
                                  : AppColors.redAccentcolor()
                              : AppColors.primaryTextColor()),
                    )
                  ],
                ),
                subtitle: Text('${task.description}',
                    style: TextStyle(color: AppColors.primaryTextColor())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

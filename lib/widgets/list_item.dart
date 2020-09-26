import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_todo/model/task.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, this.task}) : super(key: key);

  final Task task;
  
  @override
  Widget build(BuildContext context) {
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
                    Text(
                      '${task.Title}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${task.Description}',
                      style: TextStyle(
                        color: Colors.black26
                      ),
                    ),
                    SizedBox(height: 200)
                  ],
                ),
              );
            },
          );
        },
        child: Card(
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                      '${task.Title}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text('${task.Description}'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

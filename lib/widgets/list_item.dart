import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_todo/model/task.dart';

class ListItem extends StatelessWidget {
  ListItem({Key key, Task task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dismissible(
        background: Container(
          color: Colors.green,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                Text(
                  " Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.delete, color: Colors.white),
                Text('Delete ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        
        
        key: ValueKey("test"),
        child: Card(
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text(
                    'Todo item',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

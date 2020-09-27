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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                '${task.Title}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '20.02.2020',
                          style: TextStyle(
                              color: Colors.black38
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 20
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: '${task.Description}'
                            )
                          ]
                      ),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              );
            },
          );
        },
        child: Card(
          elevation: 1,
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
                          Text(
                            '${task.Title}',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '20.02.2020',
                      style: TextStyle(
                        color: Colors.black38
                      ),
                    )
                  ],
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

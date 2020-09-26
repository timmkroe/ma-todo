import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              
              title: Text('Todo item'),
              subtitle: Text('kaölskdfjalöksdfj'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Done'),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

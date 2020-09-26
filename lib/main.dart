import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_todo/adapters/firestore_repository.dart';
import 'package:ma_todo/model/task.dart';
import 'package:ma_todo/pages/Home.dart';
import 'package:ma_todo/widgets/list_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.teal,
      ),
      home: Home(),
    );
  }
}
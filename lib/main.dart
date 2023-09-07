import 'package:flutter/material.dart';
import 'package:inhameal_flutter_project/View/SwipePage.dart';
import 'package:inhameal_flutter_project/View/component/MenuBoardView.dart';
import 'View/LoadPage.dart';
import 'View/SettingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialApp',
      home: LoadPage(),
      // home: SwipePage(),
    );
  }
}


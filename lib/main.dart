import 'package:flutter/material.dart';
import 'package:flutter_carros_curso/pages/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Cars',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark
      ),
      home: LoginPage(),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_game_course/data/task_inherited.dart';
import 'package:flutter_game_course/screens/initial_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    return client;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TaskInherited(child: const InitialScreen(),),

    );
  }
}




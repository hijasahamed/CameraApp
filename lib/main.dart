
import 'package:camera_app/db/functions/db_functions.dart';
import 'package:camera_app/screens/homescreen.dart';
import 'package:flutter/material.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  HomeScreen(),
    );
  }
}


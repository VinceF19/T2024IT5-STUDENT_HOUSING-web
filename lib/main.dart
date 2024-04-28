import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_housing/screens/createCard.dart';
import 'package:student_housing/screens/dashboard.dart';
import 'package:student_housing/screens/loginWeb.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://dfozcpftfjtvxqwybcxn.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRmb3pjcGZ0Zmp0dnhxd3liY3huIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTMzNjE5MjcsImV4cCI6MjAyODkzNzkyN30.h6IfYSkX-0oNraRhuJXX0ZIN7787jFJMqZpDzzKnrpU');
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        loginWeb.routeName: (context) => const loginWeb(),
        dashboard.routeName: (context) => const dashboard(),
        CreateCard.routeName: (context) => const CreateCard(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          )),
      home: const loginWeb(),
    );
  }
}

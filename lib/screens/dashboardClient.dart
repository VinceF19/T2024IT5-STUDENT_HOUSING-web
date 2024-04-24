import 'package:flutter/material.dart';
import 'package:student_housing/main.dart';
import 'package:student_housing/screens/loginClient.dart';
import 'package:student_housing/screens/loginWeb.dart'; // Adjust import as needed

class dashboardClient extends StatefulWidget {
  static const routeName = '/dashboardClient';

  const dashboardClient({super.key});

  @override
  State<dashboardClient> createState() => _dashboardState();
}

class _dashboardState extends State<dashboardClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Dashboard!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                supabase.auth.signOut();
                Navigator.pushReplacementNamed(context, LoginClientWidget.routeName);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

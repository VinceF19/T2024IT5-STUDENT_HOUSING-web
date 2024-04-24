import 'package:flutter/material.dart';
import 'package:student_housing/main.dart';
import 'package:student_housing/screens/loginWeb.dart'; // Adjust import as needed

class dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
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
                Navigator.pushReplacementNamed(context, loginWeb.routeName);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

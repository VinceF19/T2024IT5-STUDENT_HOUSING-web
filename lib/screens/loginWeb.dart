import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_housing/main.dart';

import 'package:student_housing/screens/dashboard.dart'; // Adjust import as needed
import 'package:supabase_flutter/supabase_flutter.dart';

class loginWeb extends StatefulWidget {
  static const routeName = '/loginWeb';

  const loginWeb({Key? key}) : super(key: key);

  @override
  State<loginWeb> createState() => _loginWebState();
}

class _loginWebState extends State<loginWeb> {
  String? userId;

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        userId = data.session?.user.id;
        if (userId != null) {
          Navigator.pushReplacementNamed(context, dashboard.routeName);
        }
      });
    });
  }

  Future<void> nativeGoogleSignIn() async {
    const webClientId =
        '45249821146-lp41rn67vodjd73ehnkkjlpap6p28mqa.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                        return nativeGoogleSignIn();
                      }
                      await supabase.auth.signInWithOAuth(OAuthProvider.google);
                    } catch (error) {
                      print('Error signing in with Google: $error');
                    }
                  },
                  child: const Text("Sign in with Google"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

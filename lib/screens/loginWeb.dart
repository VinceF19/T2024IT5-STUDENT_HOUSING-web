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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.red,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(100),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 6, 116),
                          fontSize: 60,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'DORMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 191, 216),
                          fontSize: 60,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
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
                        await supabase.auth
                            .signInWithOAuth(OAuthProvider.google);
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
      ),
    );
  }
}

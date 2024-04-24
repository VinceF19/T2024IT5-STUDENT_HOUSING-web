import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_housing/main.dart';
import 'package:student_housing/screens/dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:student_housing/screens/dashboardClient.dart';

class LoginClientWidget extends StatefulWidget {
  static const routeName = 'loginClientWidget';
  const LoginClientWidget({Key? key}) : super(key: key);

  @override
  State<LoginClientWidget> createState() => _LoginClientWidgetState();
}

class _LoginClientWidgetState extends State<LoginClientWidget> {
  late TextEditingController _textController1;
  late TextEditingController _textController2;
  late FocusNode _textFieldFocusNode1;
  late FocusNode _textFieldFocusNode2;
  late FocusNode _unfocusNode;
  String? userId;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        userId = data.session?.user.id;
        if (userId != null) {
          Navigator.pushReplacementNamed(context, dashboardClient.routeName);
        }
      });
    });
    _textController1 = TextEditingController();
    _textFieldFocusNode1 = FocusNode();
    _textController2 = TextEditingController();
    _textFieldFocusNode2 = FocusNode();
    _unfocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textFieldFocusNode1.dispose();
    _textController2.dispose();
    _textFieldFocusNode2.dispose();
    _unfocusNode.dispose();

    super.dispose();
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

    return GestureDetector(
      onTap: () => _unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(170, 1, 43, 133),
                  image: DecorationImage(
                    image: AssetImage(
                      'lib/assets/addu.jpeg',
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Container(
                        height: screenHeight * 0.85,
                        width: screenWidth * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          image: DecorationImage(
                            image: AssetImage('lib/assets/addu.jpeg'),
                            opacity: 0.2,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 70, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'AD',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 13, 6, 116),
                                        fontFamily: 'Readex Pro',
                                        fontSize: 60,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      'DORMS',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 101, 191, 216),
                                        fontFamily: 'Readex Pro',
                                        fontSize: 60,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Align(
                              alignment: AlignmentDirectional(0, -1),
                              child: Text(
                                'THE ADDU ACCREDITED HOUSE FINDER',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  40, 10, 40, 0),
                              child: TextFormField(
                                controller: _textController1,
                                focusNode: _textFieldFocusNode1,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  prefixIconColor: Colors.white,
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  40, 0, 40, 20),
                              child: TextFormField(
                                controller: _textController2,
                                focusNode: _textFieldFocusNode2,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      supabase.auth.signInAnonymously();

                                      Navigator.popAndPushNamed(
                                          context, dashboardClient.routeName);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF060233),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 12),
                                      textStyle: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Login with EMAIL'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (!kIsWeb &&
                                            (Platform.isAndroid ||
                                                Platform.isIOS)) {
                                          return nativeGoogleSignIn();
                                        }
                                        await supabase.auth.signInWithOAuth(
                                            OAuthProvider.google);
                                      } catch (error) {
                                        print(
                                            'Error signing in with Google: $error');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF060233),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 12),
                                      textStyle: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text("Sign in with Google"),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 20,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 25, 0, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  supabase.auth.signInAnonymously();

                                  Navigator.popAndPushNamed(
                                      context, dashboardClient.routeName);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: const Color(0xFF060233),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  textStyle: const TextStyle(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Login as GUEST'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

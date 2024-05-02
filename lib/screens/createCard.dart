// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_housing/screens/loginWeb.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:student_housing/main.dart';
import 'package:student_housing/screens/dashboard.dart';

final TextEditingController aname = TextEditingController();
final TextEditingController aaddress = TextEditingController();
final TextEditingController adescription = TextEditingController();
final TextEditingController aprice = TextEditingController();
final TextEditingController aphoto = TextEditingController();

class CreateCard extends StatefulWidget {
  const CreateCard({Key? key}) : super(key: key);
  static const routeName = '/CreateCard';

  @override
  State<CreateCard> createState() => _CreateCardState();
}

Future<void> createCard() async {
  final response = await supabase.from('items').insert([
    {
      'name': aname.text,
      'address': aaddress.text,
      'description': adescription.text,
      'photoURL': aphoto.text,
      'price': int.tryParse(aprice.text) ?? 0,
    }
  ]);
}

class _CreateCardState extends State<CreateCard> {
  File? _image;

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        aphoto.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Fernandez & Modequillo',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, CreateCard.routeName);
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () {
                    supabase.auth.signOut();
                    Navigator.pushReplacementNamed(context, loginWeb.routeName);
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/3.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                width: screenWidth,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'AD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff252F7C),
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
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextField(
                        controller: aname,
                        decoration: InputDecoration(
                          hintText: 'Dorm Name',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: aaddress,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: adescription,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: aprice,
                        decoration: InputDecoration(
                          hintText: 'Price',
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _uploadPhoto,
                        child: Text(
                          "Upload Photo",
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              createCard();
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.lightBlue),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, dashboard.routeName);
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.lightBlue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ])),
          ),
        ),
      ),
    );
  }
}

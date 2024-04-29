// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color(0x0f252f7c),
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/addu.jpeg',
            ),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: aname,
                decoration: InputDecoration(
                  hintText: 'Dorm Name',
                ),
              ),
              TextField(
                controller: aaddress,
                decoration: InputDecoration(
                  hintText: 'Address',
                ),
              ),
              TextField(
                controller: adescription,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              TextField(
                controller: aprice,
                decoration: InputDecoration(
                  hintText: 'Price',
                ),
              ),
              ElevatedButton(
                onPressed: _uploadPhoto,
                child: Text(
                  "Upload Photo",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  createCard();
                },
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, dashboard.routeName);
                },
                child: Text(
                  "Back",
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

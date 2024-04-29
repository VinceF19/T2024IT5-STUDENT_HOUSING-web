// ignore_for_file: prefer_const_constructors

import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_housing/main.dart';
import 'package:student_housing/screens/components/itemDetails.dart';
import 'package:student_housing/screens/loginWeb.dart';
import 'package:student_housing/screens/components/itemCard.dart';
import 'package:student_housing/screens/createCard.dart';

class dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  List<Map<String, dynamic>> items = [];

  Future<void> fetchData() async {
    final data = await supabase.from('items').select('*');
    setState(() {
      items = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
              child: Column(
                children: [
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
                    child: SizedBox(
                      width: screenWidth,
                      height: screenHeight,
                      child: ListView(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 15,
                              alignment: WrapAlignment.spaceEvenly,
                              children: List.generate(
                                items.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: SizedBox(
                                      width: screenWidth * .32,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ItemCard(
                                          id: items[index]['id'].toString(),
                                          name: items[index]['name'],
                                          description: items[index]
                                              ['description'],
                                          address: items[index]['address'],
                                          photoURL: items[index]['photoURL'],
                                          price:
                                              items[index]['price'].toString(),
                                          ahidden: items[index]['hidden'],
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => ItemDetails(
                                                id: items[index]['id']
                                                    .toString(),
                                                name: items[index]['name'],
                                                description: items[index]
                                                    ['description'],
                                                address: items[index]
                                                    ['address'],
                                                photoURL: items[index]
                                                    ['photoURL'],
                                                price: items[index]['price']
                                                    .toString(),
                                                ahidden: items[index]['hidden'],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
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

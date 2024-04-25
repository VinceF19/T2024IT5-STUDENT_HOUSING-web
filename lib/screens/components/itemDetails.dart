// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemDetails extends StatelessWidget {
  final String id;
  final String name;
  final String address;
  final String description;
  final String photoURL;
  final String price;

  const ItemDetails({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.photoURL,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color(0xf252F7C),
          image: DecorationImage(
            image: AssetImage(
              'lib/assets/addu.jpeg',
            ),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      width: screenWidth * .3,
                      height: screenHeight * .3,
                      child: Image.network(
                        photoURL,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Item Name:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(name),
                            SizedBox(height: 8),
                            Text(
                              'Description:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(description),
                            SizedBox(height: 8),
                            Text(
                              'Price:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(price),
                            SizedBox(height: 8),
                            Text(
                              'Location:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(address),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

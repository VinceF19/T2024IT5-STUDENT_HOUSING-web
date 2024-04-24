// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('ID: $id'),
            Text('Address: $address'),
            Text('Address: $description'),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.network(
                photoURL,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text('Price: $price'),
          ],
        ),
      ),
    );
  }
}

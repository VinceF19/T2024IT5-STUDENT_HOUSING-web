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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),

      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      width: screenWidth * .5,
                      height: screenHeight * .5,
                      child: Image.network(
                        photoURL,
                        fit: BoxFit.fill,
                      )),
                ),
                Text(
                  'Item Name:',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      //  body: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           'Name: $name',
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         const SizedBox(height: 10),
      //         Text('ID: $id'),
      //         Text('Address: $address'),
      //         Text('Address: $description'),
      //         const SizedBox(height: 10),
      //         SizedBox(
      //           height: MediaQuery.of(context).size.height * 0.3,
      //           child: Image.network(
      //             photoURL,
      //             fit: BoxFit.contain,
      //           ),
      //         ),
      //         SizedBox(height: 10),
      //         Text('Price: $price'),
      //       ],
      //     ),
      //   ),
    );
  }
}

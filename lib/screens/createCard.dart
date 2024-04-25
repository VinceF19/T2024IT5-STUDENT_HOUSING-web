import 'package:flutter/material.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});
  static const routeName = '/CreateCard';

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Row(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

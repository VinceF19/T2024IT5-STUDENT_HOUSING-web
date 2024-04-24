import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemCard extends StatefulWidget {
  final String id;
  final String name;
  final String address;
  final String imageurl;
  final double screenWidth;
  final double initialHeight;
  final double initialWidth;

  const ItemCard({
    required this.id,
    required this.name,
    required this.address,
    required this.imageurl,
    required this.screenWidth,
    required this.initialHeight,
    required this.initialWidth,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  double cardHeight = 0;
  double cardWidth = 0;

  @override
  void initState() {
    super.initState();
    cardHeight = widget.initialHeight;
    cardWidth = widget.initialWidth;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: Color.fromARGB(255, 145, 122, 76),
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(widget.id),
                    Text(widget.name),
                    Text(widget.address),
                    SizedBox(
                        width: screenWidth * .20,
                        height: screenHeight * .20,
                        child: Image.network(
                          widget.imageurl,
                        ))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

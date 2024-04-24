import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String address;
  final String photoURL;
  final String price;
  final Function onTap;

  const ItemCard({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.photoURL,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        color: Color.fromARGB(255, 145, 122, 76),
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  photoURL,
                  fit: BoxFit.cover,
                ),
              ),
              Text(name),
              Text(address),
              Text(description),
              Text(price),
            ],
          ),
        ),
      ),
    );
  }
}

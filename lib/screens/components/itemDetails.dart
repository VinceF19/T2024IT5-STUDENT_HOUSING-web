// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_housing/main.dart';

class ItemDetails extends StatefulWidget {
  final String id;
  final String name;
  final String address;
  final String description;
  final String photoURL;
  final String price;
  final bool ahidden;

  const ItemDetails({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.photoURL,
    required this.price,
    required this.ahidden,
  }) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  late TextEditingController _ahiddenController;

  @override
  void initState() {
    super.initState();
    _ahiddenController = TextEditingController(text: widget.ahidden.toString());
  }

  @override
  void dispose() {
    _ahiddenController.dispose();
    super.dispose();
  }

  Future<void> updateItem() async {
    final newAhidden = _ahiddenController.text == 'true';
    final response = await supabase
        .from('items')
        .update({'hidden': newAhidden}).eq('id', widget.id);

    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.error!.message)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: screenWidth * .8,
        height: screenHeight * .8,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 3, 32, 161).withOpacity(.5),
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      width: screenWidth * .3,
                      height: screenHeight * .5,
                      child: Image.network(
                        widget.photoURL,
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(height: 10),
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
                                color: Color.fromARGB(255, 3, 32, 161),
                              ),
                            ),
                            Text(widget.name),
                            SizedBox(height: 8),
                            Text(
                              'Description:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 32, 161),
                              ),
                            ),
                            Text(widget.description),
                            SizedBox(height: 8),
                            Text(
                              'Price:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 32, 161),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("₱ "),
                                Text(widget.price),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Location:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 32, 161),
                              ),
                            ),
                            Text(widget.address),
                            TextField(
                              controller: _ahiddenController,
                              decoration: InputDecoration(
                                hintText: 'Hidden',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: updateItem,
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 2, 4, 146)),
                                ),
                              ),
                            ),
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

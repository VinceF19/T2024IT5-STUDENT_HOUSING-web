import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, CreateCard.routeName);
              },
              child: const Icon(Icons.add),
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
      ),
      body: Container(
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
        width: screenWidth,
        height: screenHeight,
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 15,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      items.length,
                      (index) {
                        return SizedBox(
                          width: screenWidth * .4,
                          child: ItemCard(
                            id: items[index]['id'].toString(),
                            name: items[index]['name'],
                            description: items[index]['description'],
                            address: items[index]['address'],
                            photoURL: items[index]['photoURL'],
                            price: items[index]['price'].toString(),
                            ahidden: items[index]['hidden'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetails(
                                    id: items[index]['id'].toString(),
                                    name: items[index]['name'],
                                    description: items[index]['description'],
                                    address: items[index]['address'],
                                    photoURL: items[index]['photoURL'],
                                    price: items[index]['price'].toString(),
                                    ahidden: items[index]['hidden'],
                                  ),
                                ),
                              );
                            },
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
      ),
    );
  }
}

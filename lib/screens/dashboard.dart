import 'package:flutter/material.dart';
import 'package:student_housing/main.dart';
import 'package:student_housing/screens/loginWeb.dart';
import 'package:student_housing/screens/components/itemCard.dart';

class dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  List<Map<String, dynamic>> items = [];

  Future<void> fetchData() async {
    final data = await supabase.from('dorm').select('*');
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
            const Text('Dashboard'),
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
        width: screenWidth,
        height: screenHeight,
        color: const Color(0xFFFCF7E6),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 223, 196),
            borderRadius: BorderRadius.circular(20),
          ),
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
                      return ItemCard(
                        id: items[index]['id'].toString(),
                        name: items[index]['name'],
                        address: items[index]['address'],
                        imageurl: items[index]['imageurl'],
                        screenWidth: screenWidth * .25,
                        initialHeight: screenHeight * .30,
                        initialWidth: screenWidth * .25,
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

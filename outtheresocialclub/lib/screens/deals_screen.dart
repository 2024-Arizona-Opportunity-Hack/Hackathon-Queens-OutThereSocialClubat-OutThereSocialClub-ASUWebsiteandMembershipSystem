// deals_screen.dart
import 'package:flutter/material.dart';
import 'deals_detail.dart'; // Import the new screen
// import '../services/db_connect.dart'; // Commented out: Import DB connection service

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  DealsScreenState createState() => DealsScreenState();
}

class DealsScreenState extends State<DealsScreen> {
  // final DBConnect _dbConnect = DBConnect(); // Commented out: DBConnect instance
  final List<Map<String, dynamic>> _deals = [
    // Sample deals (replace with fetched data when uncommenting DB logic)
    {'name': 'Deal 1', 'url': 'Get 50% off on all items'},
    {'name': 'Deal 2', 'url': 'Buy 1 Get 1 Free'},
  ];

  // Fetch deals when the screen loads
  @override
  void initState() {
    super.initState();
    // _loadDeals(); // Commented out: Load deals from DB
  }

  // Method to load deals from the database
  /*
  Future<void> _loadDeals() async {
    List<Map<String, dynamic>> deals = await _dbConnect.fetchDeals();
    setState(() {
      _deals = deals;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text("Deals"),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the Deals Page!",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Deals for you:",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _deals.length,
                itemBuilder: (context, index) {
                  final deal = _deals[index];
                  return ListTile(
                    leading: const Icon(Icons.local_offer),
                    title: Text(
                      deal['name'],
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      deal['url'],
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      // Navigate to the DealDetailScreen when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DealDetailScreen(deal: deal),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

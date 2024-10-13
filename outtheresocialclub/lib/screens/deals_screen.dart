// deals_screen.dart
import 'package:flutter/material.dart';
// import '../services/db_connect.dart'; // Commented out: Import DB connection service

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  _DealsScreenState createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
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
      appBar: AppBar(title: const Text("Deals")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            const Text(
              "Welcome to the Deals Page!",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center, // Ensure the text is centered
            ),
            const SizedBox(height: 20),
            const Text(
              "Deals for you:",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center, // Ensure this text is centered too
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
                      textAlign: TextAlign.center, // Center the deal title
                    ),
                    subtitle: Text(
                      deal['url'],
                      textAlign: TextAlign.center, // Center the deal subtitle
                    ),
                    onTap: () {
                      print('Selected: ${deal['name']}');
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

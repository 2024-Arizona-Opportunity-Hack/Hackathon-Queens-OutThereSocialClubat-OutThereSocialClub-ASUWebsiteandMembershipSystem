import 'package:flutter/material.dart';

class DealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deals")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the Deals Page!", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text("Deals for you:", style: TextStyle(fontSize: 18)),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(Icons.local_offer),
                  title: Text('Deal 1'),
                  subtitle: Text('Get 50% off'),
                ),
                ListTile(
                  leading: Icon(Icons.local_offer),
                  title: Text('Deal 2'),
                  subtitle: Text('Buy 1 Get 1 Free'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// deal_detail_screen.dart
import 'package:flutter/material.dart';

class DealDetailScreen extends StatelessWidget {
  final Map<String, dynamic> deal;

  const DealDetailScreen({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(deal['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deal Name: ${deal['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Details: ${deal['url']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

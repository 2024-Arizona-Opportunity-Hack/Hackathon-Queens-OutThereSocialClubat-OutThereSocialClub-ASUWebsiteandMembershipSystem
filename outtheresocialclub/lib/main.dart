import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/deals_screen.dart';
import 'screens/deals_screen.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deals App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/deals': (context) => const DealsScreen(),
        '/posts': (context) => DealsScreen(), // Added WordPress posts route
      },
    );
  }
}

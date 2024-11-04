import 'package:flutter/material.dart';
import '../services/db_connect.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// jordan's request
class _LoginScreenState extends State<LoginScreen> {
  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(
        'https://maxwellclubcom.wpcomstaging.com/membership-join/membership-registration/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  final String apiUrl =
      "https://maxwellclubcom.wpcomstaging.com/wp-json/jwt-auth/v1/token";

  Future<bool> authenticateUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Store the token for future authenticated requests
        final token = jsonDecode(response.body)['token'];
        // You can save this token in secure storage
        return true;
      }
      return false;
    } catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _dbService = WordPressDBService();
  String _username = '';
  String _password = '';

  // Simulate a login process
  // Update your login function
  void _login(String username) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final bool isAuthenticated = await authenticateUser(_username, _password);

      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/deals');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor:
            const Color.fromARGB(255, 255, 255, 255), // AppBar background color
      ),
      body: Center(
        child: SingleChildScrollView(
          // Scrollable content to avoid overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with 300x300 size
              Image.asset(
                'lib/assets/logos/OTSC_Logo_Horizontal_FullColor.png',
                width: 350,
                height: 350,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 0), // Spacing between logo and form
              Padding(
                // Card containing the login form
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(44, 44, 44, 1), // Outline color
                      width: .5, // Outline width
                    ),
                  ),
                  elevation: 0.0, // Remove shadow
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Email input field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter your email';
                              return null;
                            },
                            onSaved: (value) => _username = value!,
                          ),
                          const SizedBox(height: 20), // Spacing between fields

                          // Password input field
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            onSaved: (value) => _password = value!,
                          ),
                          const SizedBox(
                              height: 20), // Spacing before login button
                          const SizedBox(
                              height: 20), // Spacing before login button

                          // Login button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print('Username: $_username');
                                  _login(_username);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(
                                    44, 44, 44, 1), // Black button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ),
                          ),

                          // Forgot password link
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                // Handle forgot password action
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color.fromRGBO(44, 44, 44, 1),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // "Don't have an account? Apply today" link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet? "),
                  GestureDetector(
                    onTap: _launchUrl,
                    child: const Text(
                      'Join us!', //TODO: Add a link that brings the user to the the website page to register
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

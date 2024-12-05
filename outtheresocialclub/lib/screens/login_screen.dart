import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  final _logger = Logger();

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
        'https://maxwellclubcom.wpcomstaging.com/membership-join/membership-registration/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<bool> authenticateUser(String username, String password) async {
    try {
      // Step 1: Get token
      final tokenResponse = await http.post(
        Uri.parse('https://outtheresocialclub.org/wp-json/api/v1/token'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      _logger.d('Token request status: ${tokenResponse.statusCode}');
      _logger.d('Token request response: ${tokenResponse.body}');

      if (tokenResponse.statusCode == 200) {
        final tokenData = jsonDecode(tokenResponse.body);

        // Use 'jwt_token' key to get the actual token
        if (tokenData.containsKey('jwt_token') &&
            tokenData['jwt_token'] != null) {
          final token = tokenData['jwt_token'];
          _logger.d('Received token: $token');

          // Store the token securely
          await _storage.write(key: 'jwt_token', value: token);

          // Step 2: Access the membership endpoint with the token
          final response = await http.get(
            Uri.parse(
                'https://outtheresocialclub.org/wp-json/wp/v2/membership'),
            headers: {'Authorization': 'Bearer $token'},
          );

          _logger.d('Membership endpoint status code: ${response.statusCode}');
          _logger.d('Membership response body: ${response.body}');

          if (response.statusCode == 200) {
            final List<dynamic> data = jsonDecode(response.body);

            // Check if the logged-in user's account is active
            for (var member in data) {
              if (member['user_name'] == username && member['account_state'] == 'active') {
                return true;
              }
            }
            // User not found in members list or account not active
            throw Exception('User is not an active member');
          }
        } else {
          _logger.w('JWT token not found or null in response.');
        }
      } else {
        _logger.w('Token request failed with status: ${tokenResponse.statusCode}');
        _logger.d('Token request response: ${tokenResponse.body}');
      }
      return false;
    } catch (e) {
      _logger.e('Authentication error: $e');
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error connecting to server. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final bool isAuthenticated = await authenticateUser(_username, _password);

        if (!mounted) return;

        if (isAuthenticated) {
          Navigator.pushReplacementNamed(context, '/deals');
        }
      } catch (e) {
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().contains('not an active member')
                  ? 'You must be an active member to login'
                  : 'Invalid credentials'
            ),
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/logos/OTSC_Logo_Horizontal_FullColor.png',
                width: 350,
                height: 350,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(
                      color: Color.fromRGBO(44, 44, 44, 1),
                      width: .5,
                    ),
                  ),
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your email';
                              }
                              return null;
                            },
                            onSaved: (value) => _username = value!,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value!,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(44, 44, 44, 1),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account yet? "),
                  GestureDetector(
                    onTap: _launchUrl,
                    child: const Text(
                      'Join us!',
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

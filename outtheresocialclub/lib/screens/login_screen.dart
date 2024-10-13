import 'package:flutter/material.dart';
// import '../services/db_connect.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // final DBConnect _dbConnect = DBConnect(); // Instance of DBConnect
  String _username = '';
  String _password = '';

  // Simulate a login process
  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //bool isAuthenticated =
      //    await _dbConnect.authenticateUser(_username, _password);
      //
      //if (isAuthenticated) {
      //  Navigator.pushReplacementNamed(context, '/deals');
      //} else {
      //  _showErrorDialog('Invalid username or password');
      //}
      // Assuming login is successful
      Navigator.pushReplacementNamed(
          context, '/deals'); // delete this line when db is connected
    }
  }

  // TODO: Implement the authenticateUser method in the DBConnect class
  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor:
            Color.fromARGB(255, 255, 255, 255), // AppBar background color
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
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 0), // Spacing between logo and form
              Padding(
                // Card containing the login form
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 5.0,
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
                            validator: (value) {
                              if (value!.isEmpty) return 'Enter your password';
                              return null;
                            },
                            onSaved: (value) => _password = value!,
                          ),
                          const SizedBox(
                              height: 20), // Spacing before login button

                          // Login button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
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
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      // Handle apply today action
                    },
                    child: const Text(
                      'Apply today',
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

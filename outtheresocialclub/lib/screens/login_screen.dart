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
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Center content vertically
            children: [
              // Logo at the top-center of the screen
              Center(
                child: Image.asset(
                  'lib/assets/logos/OTSC_Logo_Horizontal_Black.png', // Path to your logo
                  width: 300, // Set the width of the logo
                  height: 300, // Set the height of the logo
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30), // Spacing between the logo and the form

              // Username input field
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your username';
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),

              // Password input field
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your password';
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),

              SizedBox(height: 20), // Spacing before the login button

              // Login button
              ElevatedButton(
                onPressed: _login,
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

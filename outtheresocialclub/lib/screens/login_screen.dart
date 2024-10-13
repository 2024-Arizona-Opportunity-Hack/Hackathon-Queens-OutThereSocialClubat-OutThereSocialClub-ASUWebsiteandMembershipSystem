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
      Navigator.pushReplacementNamed(context, '/deals'); // delete this line when db is connected
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
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your username';
                  return null;
                },
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Enter your password';
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

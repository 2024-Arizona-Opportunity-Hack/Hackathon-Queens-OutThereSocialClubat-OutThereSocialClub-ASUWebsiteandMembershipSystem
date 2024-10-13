import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  // Configure the connection settings
  final settings = ConnectionSettings(
    host: 'sftp.wp.com',         // e.g., '127.0.0.1' or 'your-server.com'
    port: 22,                // Default MySQL port
    user: 'maxwellclubcom.wordpress.com',     // Your MySQL username
    password: 'your-password', // Your MySQL password
    db: 'your-database',       // The name of your database
  );

  // Establish the connection
  try {
    final connection = await MySqlConnection.connect(settings);

    // Example query to fetch data from the 'users' table
    var results = await connection.query('SELECT id, name FROM users');

    // Print the results
    for (var row in results) {
      print('ID: ${row[0]}, Name: ${row[1]}');
    }

    // Close the connection
    await connection.close();
  } catch (e) {
    print('Error: $e');
  }
}
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordPressAPI {
  static const String baseUrl = 'https://your-wordpress-site.com/wp-json/wp/v2';

  Future<Map<String, dynamic>> authenticate(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/jwt-auth/v1/token'),
      body: {
        'username': username,
        'password': password,
      },
    );
    return json.decode(response.body);
  }

  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    return json.decode(response.body);
  }
}

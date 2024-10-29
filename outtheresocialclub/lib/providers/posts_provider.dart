import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/post.dart';

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final api = WordPressAPI();
  final posts = await api.getPosts();
  return posts.map((post) => Post.fromJson(post)).toList();
});

class Post {
  final int id;
  final String title;
  final String content;
  final String date;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      date: json['date'],
    );
  }
}

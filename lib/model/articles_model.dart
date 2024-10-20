class Articles {
  Articles({
    required this.articles,
  });

  final List<Article> articles;

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      articles: json["articles"] == null
          ? []
          : List<Article>.from(
              json["articles"]!.map((x) => Article.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "articles": articles.map((x) => x.toJson()).toList(),
      };
}

class Article {
  Article({
    required this.id,
    required this.goal,
    required this.tags,
    required this.title,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.publishedDate,
  });

  final int? id;
  final String? goal;
  final List<String> tags;
  final String? title;
  final String? author;
  final String? content;
  final String? imageUrl;
  final DateTime? publishedDate;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json["id"],
      goal: json["goal"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      title: json["title"],
      author: json["author"],
      content: json["content"],
      imageUrl: json["image_url"],
      publishedDate: DateTime.tryParse(json["published_date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "goal": goal,
        "tags": tags.map((x) => x).toList(),
        "title": title,
        "author": author,
        "content": content,
        "image_url": imageUrl,
        "published_date": "${publishedDate?.year.toString().padLeft(4)}-"
            "${publishedDate?.month.toString().padLeft(2)}-"
            "${publishedDate?.day.toString().padLeft(2)}",
      };
}

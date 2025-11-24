class MovieReviewsModel {
  final int id;
  final int page;
  final List<Review> results;
  final int totalPages;
  final int totalResults;

  MovieReviewsModel({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieReviewsModel.fromJson(Map<String, dynamic> json) {
    return MovieReviewsModel(
      id: json['id'],
      page: json['page'],
      results: (json['results'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class Review {
  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;

  Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      authorDetails: AuthorDetails.fromJson(json['author_details']),
      content: json['content'],
      createdAt: json['created_at'],
      id: json['id'],
      updatedAt: json['updated_at'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'author_details': authorDetails.toJson(),
      'content': content,
      'created_at': createdAt,
      'id': id,
      'updated_at': updatedAt,
      'url': url,
    };
  }
}

class AuthorDetails {
  final String name;
  final String username;
  final String? avatarPath;
  final double? rating;

  AuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) {
    return AuthorDetails(
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatarPath: json['avatar_path'],
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'avatar_path': avatarPath,
      'rating': rating,
    };
  }
}
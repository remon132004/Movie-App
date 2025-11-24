import 'package:movie_app/core/utils/entities/movie_model.dart';
import 'package:movie_app/features/search/domain/enities/search_enity.dart';

class SearchMovieResponse extends SearchMovieResponseEntity {
  final int page;
  final List<SearchMovie> results;
  final int totalPages;
  final int totalResults;

  SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  }) : super(
    page: page,
    results: results, // mapped later to entity
    totalPages: totalPages,
    totalResults: totalResults,
  );

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) {
    final resultsList = (json['results'] as List)
        .map((item) => SearchMovie.fromJson(item))
        .toList();

    return SearchMovieResponse(
      page: json['page'],
      results: resultsList,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((item) => item.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class SearchMovie extends Movie {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  SearchMovie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  }) : super(
    adult: adult,
    backdropPath: backdropPath,
    genreIds: genreIds,
    id: id,
    originalLanguage: originalLanguage,
    originalTitle: originalTitle,
    overview: overview,
    popularity: popularity,
    posterPath: posterPath,
    releaseDate: releaseDate,
    title: title,
    video: video,
    voteAverage: voteAverage,
    voteCount: voteCount,
  );

  factory SearchMovie.fromJson(Map<String, dynamic> json) {
    return SearchMovie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'] ?? "",
      title: json['title'],
      video: json['video'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Move the part directive to the top
part 'movie_model.g.dart';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  Model({
    this.page,
    required this.movies,
    this.totalPages,
    this.totalMovies,
  });

  int? page;
  List<Movie> movies;
  int? totalPages;
  int? totalMovies;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalMovies: json["total_Movies"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "Movies": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_Movies": totalMovies,
      };
}

@HiveType(typeId: 0)
class Movie extends Equatable {
  @HiveField(0)
  bool? adult;

  @HiveField(1)
  String? backdropPath;

  @HiveField(2)
  int? id;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? originalTitle;

  @HiveField(5)
  String? overview;

  @HiveField(6)
  String? posterPath;

  @HiveField(7)
  List<int>? genreIds;

  @HiveField(8)
  double? popularity;

  @HiveField(9)
  DateTime? releaseDate;

  @HiveField(10)
  MediaType? mediaType;

  @HiveField(11)
  bool? video;

  @HiveField(12)
  double? voteAverage;

  @HiveField(13)
  int? voteCount;

  @HiveField(14)
  String? name;

  @HiveField(15)
  String? originalName;

  @HiveField(16)
  DateTime? firstAirDate;

  @HiveField(17)
  List<String>? originCountry;

  Movie({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.mediaType,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  @override
  List<Object?> get props => [
        id,
        title,
      ];

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        releaseDate: (json["release_date"] ?? "").isEmpty
            ? null
            : DateTime.parse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
        firstAirDate: json["first_air_date"] == null
            ? null
            : DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        mediaType: mediaTypeValues.map[json["media_type"]],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "popularity": popularity,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate?.day.toString().padLeft(2, '0')}",
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
      };
}

enum MediaType { movie, tv }

final mediaTypeValues =
    EnumValues({"movie": MediaType.movie, "tv": MediaType.tv});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}

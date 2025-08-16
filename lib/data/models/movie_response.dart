
import 'package:cine_box/data/models/movie_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse{

  final int page;
  final List<MovieItem> movies;
  final int totalResults;
  final int totalPages;

  MovieResponse(this.movies, this.page, this.totalResults, this.totalPages);

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
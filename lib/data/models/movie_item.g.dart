// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieItem _$MovieItemFromJson(Map<String, dynamic> json) => MovieItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  genreIds: (json['genreIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  backdropPath: json['backdropPath'] as String?,
  overview: json['overview'] as String,
  posterPath: json['posterPath'] as String?,
  releaseDate: json['releaseDate'] as String?,
  voteAverage: (json['voteAverage'] as num).toDouble(),
);

Map<String, dynamic> _$MovieItemToJson(MovieItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'genreIds': instance.genreIds,
  'backdropPath': instance.backdropPath,
  'overview': instance.overview,
  'posterPath': instance.posterPath,
  'releaseDate': instance.releaseDate,
  'voteAverage': instance.voteAverage,
};

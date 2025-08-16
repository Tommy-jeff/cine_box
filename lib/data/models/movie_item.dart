// {
//  "adult": false,
//  "backdrop_path": "/s94NjfKkcSczZ1FembwmQZwsuwY.jpg",
//  "genre_ids": [
//     878,
//     12
//   ],
//  "id": 617126,
//  "original_language": "en",
//  "original_title": "The Fantastic 4: First Steps",
//  "overview": "No vibrante cenário de um mundo retrofuturista inspirado nos anos 1960, a Primeira Família da Marvel é forçada a equilibrar seus papéis como heróis com a força de seus laços familiares, enquanto defendem a Terra de um deus espacial voraz chamado Galactus e sua enigmática arauta, a Surfista Prateada.",
//  "popularity": 163.6361,
//  "poster_path": "/hlWOAWRKSno6UxaE0IXDFVvmzTf.jpg",
//  "release_date": "2025-07-23",
//  "title": "Quarteto Fantástico: Primeiros Passos",
//  "video": false,
//  "vote_average": 7.245,
//  "vote_count": 988
// }

import 'package:json_annotation/json_annotation.dart';

part 'movie_item.g.dart';

@JsonSerializable()
class MovieItem {
  final int id;
  final String title;
  final List<int>? genreIds;
  final String? backdropPath;
  final String overview;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;

  MovieItem({
    required this.id,
    required this.title,
    this.genreIds,
    this.backdropPath,
    required this.overview,
    this.posterPath,
    this.releaseDate,
    required this.voteAverage,
  });

  factory MovieItem.fromJson(Map<String, dynamic> json) =>
      _$MovieItemFromJson(json);

  Map<String, dynamic> toJson() => _$MovieItemToJson(this);
}

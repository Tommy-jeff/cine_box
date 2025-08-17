import 'dart:developer';

import 'package:cine_box/data/models/genre_response.dart';
import 'package:cine_box/data/models/movie_response.dart';
import 'package:cine_box/domain/models/genre.dart';
import 'package:cine_box/domain/models/movie.dart';

class MovieMapper {
  static List<Movie> mapToMovies(MovieResponse movieResponse) {
    return movieResponse.results
        .map(
          (response) => Movie(
            id: response.id,
            title: response.title,
            overview: response.overview,
            genresId: response.genreIds ?? [],
            voteAverage: response.voteAverage ?? 0.0,
            posterPath: response.posterPath ?? '',
            backdropPath: response.backdropPath ?? '',
            releaseDate: response.releaseDate ?? '',
          ),
        )
        .toList();
  }

  static List<Genre> mapToGenres(GenreResponse genreResponse) {
    return genreResponse.genres
        .map((response) => Genre(id: response.id, name: response.name))
        .toList();
  }
}

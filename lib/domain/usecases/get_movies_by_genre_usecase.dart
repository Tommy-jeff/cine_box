import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/repositories/movies/movies_repository.dart';
import 'package:cine_box/data/repositories/tmdb/tmdb_repository.dart';
import 'package:cine_box/domain/extensions/mark_favorite_extension.dart';
import 'package:cine_box/domain/models/favorite_movies.dart';
import 'package:cine_box/domain/models/movie.dart';

class GetMoviesByGenreUsecase {
  final TmdbRepository _tmdbRepository;
  final MoviesRepository _moviesRepository;

  GetMoviesByGenreUsecase({
    required TmdbRepository tmdbRepository,
    required MoviesRepository moviesRepository,
  }) : _tmdbRepository = tmdbRepository,
       _moviesRepository = moviesRepository;

  Future<Result<List<Movie>>> execute({required int genreId}) async {
    final results = await Future.wait([
      _moviesRepository.getFavoriteMovies(),
      _tmdbRepository.getMoviesByGenre(genreId: genreId),
    ]);

    if (results case [
      Success<List<FavoriteMovie>>(value: final favorites),
      Success<List<Movie>>(value: final movies),
    ]) {
      final favoritesIDs = favorites.map((f) => f.id).toList();
      return Success(movies.markAsFavorite(favoritesIDs));
    }

    return Failure(Exception('Error in execute GetMoviesByGenreUsecase'));
  }
}

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/repositories/movies/movies_repository.dart';
import 'package:cine_box/data/repositories/tmdb/tmdb_repository.dart';
import 'package:cine_box/domain/extensions/mark_favorite_extension.dart';
import 'package:cine_box/domain/models/favorite_movies.dart';
import 'package:cine_box/domain/models/movie.dart';
import 'package:cine_box/domain/models/movies_by_category.dart';

class GetMoviesByCategoryUsecase {
  final TmdbRepository _tmdbRepository;
  final MoviesRepository _moviesRepository;

  GetMoviesByCategoryUsecase({
    required TmdbRepository tmdbRepository,
    required MoviesRepository moviesRepository,
  }) : _tmdbRepository = tmdbRepository,
       _moviesRepository = moviesRepository;

  Future<Result<MoviesByCategory>> execute() async {
    var results = await Future.wait([
      _moviesRepository.getFavoriteMovies(),
      _tmdbRepository.getPopularMovies(),
      _tmdbRepository.getTopRatedMovies(),
      _tmdbRepository.getNowPlayingMovies(),
      _tmdbRepository.getUpcomingMovies(),
    ]);
    if (results case [
      Success<List<FavoriteMovies>>(value: final favorites),
      Success<List<Movie>>(value: final popular),
      Success<List<Movie>>(value: final topRated),
      Success<List<Movie>>(value: final nowPlaying),
      Success<List<Movie>>(value: final upcoming),
    ]) {
      final favoritesIDs = favorites.map((f) => f.id).toList();
      return Success(
        MoviesByCategory(
          popular: popular.markAsFavorite(favoritesIDs),
          topRated: topRated.markAsFavorite(favoritesIDs),
          nowPlaying: nowPlaying.markAsFavorite(favoritesIDs),
          upcoming: upcoming.markAsFavorite(favoritesIDs),
        ),
      );
    }

    return Failure(Exception('Error in get movies by category'));
  }
}

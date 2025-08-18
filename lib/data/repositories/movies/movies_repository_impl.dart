import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/exceptions/data_exception.dart';
import 'package:cine_box/data/mappers/movie_mapper.dart';
import 'package:cine_box/data/models/save_favorite_movie.dart';
import 'package:cine_box/data/repositories/movies/movies_repository.dart';
import 'package:cine_box/data/services/movies/movies_service.dart';
import 'package:cine_box/domain/models/favorite_movies.dart';
import 'package:dio/dio.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieService _movieService;

  MoviesRepositoryImpl({required MovieService movieService})
    : _movieService = movieService;

  @override
  Future<Result<List<FavoriteMovie>>> getFavoriteMovies() async {
    try {
      final response = await _movieService.getFavoriteMovies();
      final favorites = MovieMapper.mapToFavorites(response);

      return Success(favorites);
    } on DioException catch (e, s) {
      log('Error in getFavoriteMovies', error: e, stackTrace: s);
      return Failure(DataException(message: 'Error in getFavoriteMovies'));
    }
  }

  @override
  Future<Result<Unit>> deleteFavoriteMovie({required int movieId}) async {
    try {
      await _movieService.deleteFavoriteMovie(movieId);
      return successOfUnit();
    } on DioException catch (e, s) {
      log('Error in deleteFavoriteMovie', error: e, stackTrace: s);
      return Failure(DataException(message: 'Error in deleteFavoriteMovie'));
    }
  }

  @override
  Future<Result<Unit>> saveFavoriteMovie({
    required FavoriteMovie favoriteMovie,
  }) async {
    try {
      await _movieService.saveFavoriteMovie(
        SaveFavoriteMovie(
          movieId: favoriteMovie.id,
          posterUrl: favoriteMovie.posterPath,
          title: favoriteMovie.title,
          year: favoriteMovie.year,
        ),
      );
      return successOfUnit();
    } on DioException catch (e, s) {
      log('Error in saveFavoriteMovie', error: e, stackTrace: s);
      return Failure(DataException(message: 'Error in saveFavoriteMovie'));
    }
  }
}

import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/exceptions/data_exception.dart';
import 'package:cine_box/data/mappers/movie_mapper.dart';
import 'package:cine_box/data/repositories/movies/movies_repository.dart';
import 'package:cine_box/data/services/movies/movies_service.dart';
import 'package:cine_box/domain/models/favorite_movies.dart';
import 'package:dio/dio.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieService _movieService;

  MoviesRepositoryImpl({required MovieService movieService})
    : _movieService = movieService;

  @override
  Future<Result<List<FavoriteMovies>>> getFavoriteMovies() async {
    try {
      final response = await _movieService.getFavoriteMovies();
      final favorites = MovieMapper.mapToFavorites(response);

      return Success(favorites);
    } on DioException catch (e, s) {
      log('Error in getFavoriteMovies', error: e, stackTrace: s);
      return Failure(DataException(message: 'Error in getFavoriteMovies'));
    }
  }
}

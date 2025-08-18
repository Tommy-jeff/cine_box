import 'dart:developer';

import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/data/exceptions/data_exception.dart';
import 'package:cine_box/data/mappers/movie_mapper.dart';
import 'package:cine_box/data/repositories/tmdb/tmdb_repository.dart';
import 'package:cine_box/data/services/tmdb/tmdb_service.dart';
import 'package:cine_box/domain/models/genre.dart';
import 'package:cine_box/domain/models/movie.dart';
import 'package:dio/dio.dart';

class TmdbRepositoryImpl implements TmdbRepository {
  final TmdbService _tmdbService;

  TmdbRepositoryImpl({required TmdbService tmdbService})
    : _tmdbService = tmdbService;

  @override
  Future<Result<List<Genre>>> getGenres() async {
    try {
      final genresData = await _tmdbService.getMoviesGenres();

      return Success(MovieMapper.mapToGenres(genresData));
    } on DioException catch (e, s) {
      log(
        'Error in getGenres',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in getGenres'),
      );
    }
  }

  @override
  Future<Result<List<Movie>>> getPopularMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getPopularMovies(
        language: language,
        page: page,
      );
      return Success(MovieMapper.mapToMovies(moviesData));
    } on DioException catch (e, s) {
      log(
        'Error in getPopularMovies',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in getPopularMovies'),
      );
    }
  }

  @override
  Future<Result<List<Movie>>> getTopRatedMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getTopRatedMovies(
        language: language,
        page: page,
      );
      return Success(MovieMapper.mapToMovies(moviesData));
    } on DioException catch (e, s) {
      log(
        'Error in getPopularMovies',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in getPopularMovies'),
      );
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlayingMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getNowPlayingMovies(
        language: language,
        page: page,
      );
      return Success(MovieMapper.mapToMovies(moviesData));
    } on DioException catch (e, s) {
      log(
        'Error in getPopularMovies',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in getPopularMovies'),
      );
    }
  }

  @override
  Future<Result<List<Movie>>> getUpcomingMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getUpcomingMovies(
        language: language,
        page: page,
      );
      return Success(MovieMapper.mapToMovies(moviesData));
    } on DioException catch (e, s) {
      log(
        'Error in getPopularMovies',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in getPopularMovies'),
      );
    }
  }

  @override
  Future<Result<List<Movie>>> getMoviesByGenre({required int genreId}) async {
    try {
      final data = await _tmdbService.discoverMovies(
        withGenres: genreId.toString(),
      );

      return Success(MovieMapper.mapToMovies(data));
    } on DioException catch (e, s) {
      log(
        'Error in getMoviesByGenre',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in getMoviesByGenre'),
      );
    }
  }

  @override
  Future<Result<List<Movie>>> searchMovies({required String query}) async {
    try {
      final data = await _tmdbService.searchMovies(query: query);

      return Success(MovieMapper.mapToMovies(data));
    } on DioException catch (e, s) {
      log(
        'Error in searchMovies',
        error: e,
        stackTrace: s,
      );
      return Failure(
        DataException(message: 'Error in searchMovies'),
      );
    }
  }
}

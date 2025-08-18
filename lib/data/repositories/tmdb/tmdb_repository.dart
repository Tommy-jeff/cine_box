import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/domain/models/genre.dart';
import 'package:cine_box/domain/models/movie.dart';

abstract interface class TmdbRepository{

  Future<Result<List<Genre>>> getGenres();

  Future<Result<List<Movie>>> getPopularMovies({String language,int page});

  Future<Result<List<Movie>>> getTopRatedMovies({String language,int page});

  Future<Result<List<Movie>>> getNowPlayingMovies({String language,int page});

  Future<Result<List<Movie>>> getUpcomingMovies({String language,int page});

  Future<Result<List<Movie>>> searchMovies({required String query});

  Future<Result<List<Movie>>> getMoviesByGenre({required int genreId});


}
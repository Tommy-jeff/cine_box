import 'package:cine_box/core/result/result.dart';
import 'package:cine_box/domain/models/genre.dart';
import 'package:cine_box/domain/models/movie.dart';

abstract interface class TmdbRepository{

  Future<Result<List<Genre>>> getGenres();

  Future<Result<List<Movie>>> getPopularMovies({String language,int page});

  Future<Result<List<Movie>>> getTopRatedMovies({String language,int page});

  Future<Result<List<Movie>>> getNowPlayingMovies({String language,int page});

  Future<Result<List<Movie>>> getUpcomingMovies({String language,int page});

  // Future<Result<List<Movie>>> searchMovies({String query,String language,int page, String region});
  //
  // Future<Result<List<Movie>>> discoverMovies({String language,int page, String region, String sortBt, String withGenres});


}
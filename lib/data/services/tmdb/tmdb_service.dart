import 'package:cine_box/data/models/genre_response.dart';
import 'package:cine_box/data/models/movie_details_response.dart';
import 'package:cine_box/data/models/movie_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'tmdb_service.g.dart';

@RestApi()
abstract class TmdbService {
  factory TmdbService(Dio dio, {String baseUrl}) = _TmdbService;

  @GET('genre/movie/list')
  Future<GenreResponse> getMoviesGenres({
    @Query('language') String language = 'pt-BR',
  });

  @GET('/movie/popular')
  Future<MovieResponse> getPopularMovies({
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Query('region') String region = 'BR',
  });

  @GET('/movie/top_rated')
  Future<MovieResponse> getTopRatedMovies({
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Query('region') String region = 'BR',
  });

  @GET('/movie/now_playing')
  Future<MovieResponse> getNowPlayingMovies({
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Query('region') String region = 'BR',
  });

  @GET('/movie/upcoming')
  Future<MovieResponse> getUpcomingMovies({
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Query('region') String region = 'BR',
  });

  @GET('/search/movie')
  Future<MovieResponse> searchMovies({
    @Query('query') required String query,
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Query('region') String region = 'BR',
  });

  @GET('/discover/movie')
  Future<MovieResponse> discoverMovies({
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Query('region') String region = 'BR',
    @Query('sort_by') String sortBt = 'popularity.desc',
    @Query('with_genres') String withGenres,
  });

  @GET('/movie/{movie_id}/?include_image_language=pt,null')
  Future<MovieDetailsResponse> getMovieDetails({
    @Query('language') String language = 'pt-BR',
    @Query('page') int page = 1,
    @Path('movie_id') int movieId,
    @Query('append_to_response') String appendToResponse = '',
  });
}

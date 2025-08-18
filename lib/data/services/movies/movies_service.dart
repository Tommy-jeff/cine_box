import 'package:cine_box/data/models/favorite_movie_response.dart';
import 'package:cine_box/data/models/save_favorite_movie.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio) = _MovieService;

  @GET('/favorite')
  Future<List<FavoriteMovieResponse>> getFavoriteMovies();

  @DELETE('/favorite/{movie_id}')
  Future<void> deleteFavoriteMovie(@Path('movie_id') int movieId);

  @POST('/favorite')
  Future<void> saveFavoriteMovie(@Body() SaveFavoriteMovie request);

}


import 'package:cine_box/data/models/favorite_movie_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_service.g.dart';

@RestApi()
abstract class MovieService {

  factory MovieService(Dio dio) = _MovieService;

  @GET('/favorite')
  Future<List<FavoriteMovieResponse>> getFavoriteMovies();


}
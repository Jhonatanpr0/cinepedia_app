import 'package:cinepedia_app/config/constants/environment.dart';
import 'package:cinepedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinepedia_app/domain/entities/actor.dart';
import 'package:cinepedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinepedia_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDBKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();

    return actors;
  }
}

import 'package:cinepedia_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future <List<Movie>> getNowPlaying({int page =1});
  Future <List<Movie>> getPopular({int page =1});
  Future <List<Movie>> getUpcoming({int page =1});
  Future <List<Movie>> getTopRatend({int page =1});
  Future <Movie> getMovieById(String id);
}

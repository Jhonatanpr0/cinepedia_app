import 'package:cinepedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinepedia_app/domain/entities/movie.dart';
import 'package:cinepedia_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}

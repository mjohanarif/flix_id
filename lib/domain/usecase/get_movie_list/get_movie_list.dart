import 'package:flix_id/data/repository/movie_repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_movie_list/get_movie_list_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParam> {
  final MovieRepository _movieRepository;

  GetMovieList({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParam params) async {
    final result = switch (params.category) {
      MovieListCategory.nowPlaying => await _movieRepository.getNowPlaying(),
      MovieListCategory.upcoming => await _movieRepository.getUpcoming(),
    };

    return switch (result) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message),
    };
  }
}

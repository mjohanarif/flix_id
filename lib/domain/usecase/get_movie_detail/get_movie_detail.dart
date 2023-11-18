import 'package:flix_id/data/repository/movie_repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_movie_detail/get_movie_detail_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class GetMovieDetail
    implements UseCase<Result<MovieDetail>, GetMovieDetailParam> {
  final MovieRepository _movieRepository;

  GetMovieDetail({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParam params) async {
    final result = await _movieRepository.getDetail(id: params.movie.id);

    return switch (result) {
      Success(value: final detail) => Result.success(detail),
      Failed(:final message) => Result.failed(message),
    };
  }
}

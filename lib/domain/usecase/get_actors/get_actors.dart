import 'package:flix_id/data/repository/movie_repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_actors/get_actors_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParam> {
  final MovieRepository _movieRepository;

  GetActors({
    required MovieRepository movieRepository,
  }) : _movieRepository = movieRepository;

  @override
  Future<Result<List<Actor>>> call(GetActorsParam params) async {
    final result = await _movieRepository.getActors(id: params.movieId);

    return switch (result) {
      Success(value: final actors) => Result.success(actors),
      Failed(:final message) => Result.failed(message),
    };
  }
}

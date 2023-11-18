import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_actors/get_actors.dart';
import 'package:flix_id/domain/usecase/get_actors/get_actors_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_actors_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors getActors = ref.read(getActorsProvider);

  final result = await getActors(
    GetActorsParam(
      movieId: movieId,
    ),
  );

  return switch (result) {
    Success(value: final actors) => actors,
    Failed() => const [],
  };
}

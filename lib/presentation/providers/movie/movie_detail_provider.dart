import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_movie_detail/get_movie_detail.dart';
import 'package:flix_id/domain/usecase/get_movie_detail/get_movie_detail_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref,
    {required Movie movie}) async {
  GetMovieDetail getMovieDetail = ref.read(getMovieDetailProvider);

  final result = await getMovieDetail(
    GetMovieDetailParam(movie: movie),
  );

  return switch (result) {
    Success(value: final movieDetail) => movieDetail,
    Failed() => null,
  };
}

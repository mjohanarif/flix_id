import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_movie_list/get_movie_list.dart';
import 'package:flix_id/domain/usecase/get_movie_list/get_movie_list_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_provider.g.dart';

@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => const [];

  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();

    GetMovieList getMovieList = ref.read(getMovieListProvider);

    var result = getMovieList(
      GetMovieListParam(
        category: MovieListCategory.upcoming,
        page: page,
      ),
    );
    switch (result) {
      case Success(value: final movies):
        state = AsyncData(movies);
      case Failed():
        state = const AsyncData([]);
    }
  }
}

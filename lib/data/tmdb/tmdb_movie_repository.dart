import 'package:dio/dio.dart';
import 'package:flix_id/data/repository/movie_repository.dart';
import 'package:flix_id/domain/entities/actor.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/result.dart';

class TmdbMovieRepository implements MovieRepository {
  final Dio? _dio;
  final String _accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MzMyMjM2MGJiNWQzMWZhMzc3NjVkOTc4MzI0NjIyMyIsInN1YiI6IjYxNjNmOGNhOWQ1OTJjMDA4OTg3ZGFiZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IKbInOuY3_sO-Iv8EndphylgIa80r7Nq-LHtWXbFh3Q';

  late final Options _options = Options(headers: {
    'Authorization': 'Bearer $_accessToken',
    'accept': 'application/json',
  });

  TmdbMovieRepository({Dio? dio}) : _dio = dio ?? Dio();
  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
        options: _options,
      );

      final result = List<Map<String, dynamic>>.from(response.data['cast']);

      return Result.success(
        result.map((e) => Actor.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$id?language=en-US',
        options: _options,
      );

      return Result.success(
        MovieDetail.fromJson(response.data),
      );
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async => _getMovies(
        category: _MovieCategory.nowPlaying._instring,
        page: page,
      );

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async => _getMovies(
        category: _MovieCategory.upcoming._instring,
        page: page,
      );

  Future<Result<List<Movie>>> _getMovies({
    required String category,
    int page = 1,
  }) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
        options: _options,
      );

      final result = List<Map<String, dynamic>>.from(
        response.data['results'],
      );

      return Result.success(
        result.map((e) => Movie.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String _instring;

  const _MovieCategory(String instring) : _instring = instring;
}

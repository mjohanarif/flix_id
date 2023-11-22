import 'package:flix_id/data/repository/authentication_repository.dart';
import 'package:flix_id/domain/entities/result.dart';

class DummyAuthenticationRepository implements AuthenticationRepostirory {
  @override
  String? getLoggedInUserId() {
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    // return const Result.success('ID-12345');
    return const Result.failed('Gagal login');
  }

  @override
  Future<Result<void>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) {
    throw UnimplementedError();
  }
}

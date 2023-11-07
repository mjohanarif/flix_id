import 'package:flix_id/domain/entities/entities.dart';

abstract interface class AuthenticationRepostirory {
  Future<Result<User>> register({
    required String email,
    required String password,
  });

  Future<Result<User>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logout({
    String? getLoggedInUserId,
  });
}

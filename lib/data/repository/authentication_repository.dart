import 'package:flix_id/domain/entities/entities.dart';

abstract interface class AuthenticationRepostirory {
  Future<Result<String>> register({
    required String email,
    required String password,
  });

  Future<Result<String>> login({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();

  String? getLoggedInUserId();
}

import 'dart:io';

import 'package:flix_id/domain/entities/entities.dart';

abstract interface class AuthenticationRepostirory {
  Future<Result<User>> createUser({
    required String email,
    required String name,
    required String uid,
    String? photoUrl,
    int balance = 0,
  });

  Future<Result<User>> getUser({
    required String uid,
  });

  Future<Result<User>> updateUser({
    required User user,
  });

  Future<Result<int>> getUserBalance({
    required String uid,
  });

  Future<Result<User>> updateUserBalance({
    required String uid,
    required int balance,
  });
  Future<Result<User>> updateProfilePicture({
    required String uid,
    required File imageFile,
  });
}

import 'dart:io';

import 'package:flix_id/data/repository/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';

class DummyUserRepository implements UserRepostirory {
  @override
  Future<Result<User>> createUser(
      {required String email,
      required String name,
      required String uid,
      String? photoUrl,
      int balance = 0}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({
    required String uid,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Result.success(User(
      uid: uid,
      email: 'email@gmail.com',
      name: 'Arifin',
    ));
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateProfilePicture(
      {required User user, required File imageFile}) {
    // TODO: implement updateProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser({required User user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) {
    // TODO: implement updateUserBalance
    throw UnimplementedError();
  }
}

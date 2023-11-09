import 'dart:io';

import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepository implements UserRepostirory {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();

    if (result.exists) {
      return Result.success(
        User.fromJson(result.data()!),
      );
    } else {
      return const Result.failed('user not found');
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateProfilePicture(
      {required String uid, required File imageFile}) {
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

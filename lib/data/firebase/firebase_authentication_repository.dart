import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FirebaseAuthenticationRepository implements AuthenticationRepostirory {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      final authCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(
        authCredential.user!.uid,
      );
    } on firebase_auth.FirebaseException catch (e) {
      return Result.failed(
        e.message!,
      );
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();
    if (_firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed('Failed to sign out');
    }
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

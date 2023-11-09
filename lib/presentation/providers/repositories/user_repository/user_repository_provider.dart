import 'package:flix_id/data/firebase/firebase.dart';
import 'package:flix_id/data/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepostirory userRepository(UserRepositoryRef ref) =>
    FirebaseUserRepository();

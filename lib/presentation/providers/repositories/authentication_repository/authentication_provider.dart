import 'package:flix_id/data/firebase/firebase.dart';
import 'package:flix_id/data/repository/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@riverpod
AuthenticationRepostirory authenticationRepostirory(
        AuthenticationRepostiroryRef ref) =>
    FirebaseAuthenticationRepository();

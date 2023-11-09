import 'package:flix_id/domain/usecase/login/login.dart';
import 'package:flix_id/presentation/providers/repositories/authentication_repository/authentication_provider.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
      authenticationRepostitory: ref.watch(authenticationRepostiroryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );

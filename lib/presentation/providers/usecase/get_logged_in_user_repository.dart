import 'package:flix_id/domain/usecase/get_logged_in_user/get_logged_in_user.dart';
import 'package:flix_id/presentation/providers/repositories/authentication_repository/authentication_provider.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_repository.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
      authenticationRepostirory: ref.watch(authenticationRepostiroryProvider),
      userRepostirory: ref.watch(
        userRepositoryProvider,
      ),
    );

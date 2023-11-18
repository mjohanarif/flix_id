import 'package:flix_id/domain/usecase/logout/logout.dart';
import 'package:flix_id/presentation/providers/repositories/authentication_repository/authentication_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) => Logout(
      authenticationRepostirory: ref.watch(
        authenticationRepostiroryProvider,
      ),
    );

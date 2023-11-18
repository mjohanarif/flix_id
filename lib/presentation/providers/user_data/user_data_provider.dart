import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_logged_in_user/get_logged_in_user.dart';
import 'package:flix_id/domain/usecase/login/login.dart';
import 'package:flix_id/domain/usecase/logout/logout.dart';
import 'package:flix_id/domain/usecase/register/register.dart';
import 'package:flix_id/domain/usecase/register/register_param.dart';
import 'package:flix_id/domain/usecase/top_up/top_up.dart';
import 'package:flix_id/domain/usecase/top_up/top_up_param.dart';
import 'package:flix_id/domain/usecase/upload_profile_picture/upload_profile_picture.dart';
import 'package:flix_id/domain/usecase/upload_profile_picture/upload_profile_picture_param.dart';

import 'package:flix_id/presentation/providers/movie/now_playing_provider.dart';
import 'package:flix_id/presentation/providers/movie/upcoming_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecase/get_logged_in_user_repository.dart';
import 'package:flix_id/presentation/providers/usecase/login_provider.dart';
import 'package:flix_id/presentation/providers/usecase/logout_provider.dart';
import 'package:flix_id/presentation/providers/usecase/register_provider.dart';
import 'package:flix_id/presentation/providers/usecase/top_up_provider.dart';
import 'package:flix_id/presentation/providers/usecase/upload_profile_picture_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    final result = await getLoggedInUser(null);
    switch (result) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed():
        return null;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    Login login = ref.read(loginProvider);
    final result = await login(
      LoginParams(email: email, password: password),
    );

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required RegisterParam param,
  }) async {
    state = const AsyncLoading();
    Register register = ref.read(registerProvider);
    final result = await register(
      RegisterParam(
        name: param.name,
        email: param.email,
        password: param.password,
      ),
    );

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    final result = await getLoggedInUser(null);
    if (result is Success) {
      state = AsyncData(result.resultValue);
    }
  }

  Future<void> logOut() async {
    Logout logout = ref.read(logoutProvider);
    final result = await logout(null);
    switch (result) {
      case Success():
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp({required int amount}) async {
    TopUp topUp = ref.read(topUpProvider);
    final userId = state.valueOrNull?.uid;

    if (userId != null) {
      final result = await topUp(
        TopUpParam(amount: amount, userId: userId),
      );

      if (result.isSuccess) {
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture({
    required UploadProfilePictureParam param,
  }) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    final result = await uploadProfilePicture(param);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upcomingProvider.notifier).getMovies();
  }
}

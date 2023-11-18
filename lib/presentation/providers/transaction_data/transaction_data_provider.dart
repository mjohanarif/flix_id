import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_transactions/get_transactions.dart';
import 'package:flix_id/domain/usecase/get_transactions/get_transactions_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_transactions_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;
    if (user != null) {
      state = const AsyncLoading();
      GetTransaction getTransaction = ref.read(getTransactionProvider);
      final result = await getTransaction(
        GetTransactionParam(
          uid: user.uid,
        ),
      );

      if (result case Success(value: final transaction)) {
        return transaction;
      }
    }
    return const [];
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();
      GetTransaction getTransaction = ref.read(getTransactionProvider);

      final result = await getTransaction(
        GetTransactionParam(
          uid: user.uid,
        ),
      );

      switch (result) {
        case Success(value: final transactioons):
          state = AsyncData(transactioons);

        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}

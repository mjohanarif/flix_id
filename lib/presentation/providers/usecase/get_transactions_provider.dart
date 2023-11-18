import 'package:flix_id/domain/usecase/get_transactions/get_transactions.dart';
import 'package:flix_id/presentation/providers/repositories/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transactions_provider.g.dart';

@riverpod
GetTransaction getTransaction(GetTransactionRef ref) => GetTransaction(
      transactionRepository: ref.watch(transactionRepositoryProvider),
    );

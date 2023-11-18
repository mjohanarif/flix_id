import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_transactions/get_transactions_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParam> {
  final TransactionRepository _transactionRepository;

  const GetTransaction({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;
  @override
  Future<Result<List<Transaction>>> call(GetTransactionParam params) async {
    final result =
        await _transactionRepository.getUserTransaction(uid: params.uid);

    return switch (result) {
      Success(value: final transactions) => Result.success(transactions),
      Failed(:final message) => Result.failed(message),
    };
  }
}

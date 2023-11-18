import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/create_transaction/create_transaction_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParam> {
  final TransactionRepository _transactionRepository;

  const CreateTransaction({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(CreateTransactionParam params) async {
    final result = await _transactionRepository.createTransaction(
        transaction: params.transaction);

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}

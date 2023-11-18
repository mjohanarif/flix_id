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
    final transactionTime = DateTime.now().millisecondsSinceEpoch;
    final result = await _transactionRepository.createTransaction(
      transaction: params.transaction.copyWith(
        transactionTime: transactionTime,
        id: (params.transaction.id == null)
            ? 'flx-$transactionTime-${params.transaction.uid}'
            : params.transaction.id,
      ),
    );

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed(:final message) => Result.failed(message),
    };
  }
}

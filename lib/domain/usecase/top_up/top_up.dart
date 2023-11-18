import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecase/create_transaction/create_transaction_param.dart';
import 'package:flix_id/domain/usecase/top_up/top_up_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class TopUp implements UseCase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  const TopUp({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParam params) async {
    CreateTransaction createTransaction = CreateTransaction(
      transactionRepository: _transactionRepository,
    );

    final transactionTime = DateTime.now().millisecondsSinceEpoch;

    final result = await createTransaction(CreateTransactionParam(
      transaction: Transaction(
        uid: params.userId,
        title: 'Top up',
        adminFee: 0,
        total: -params.amount,
        transactionTime: transactionTime,
        id: 'flxtp-$transactionTime-${params.userId}',
      ),
    ));

    return switch (result) {
      Success(value: _) => const Result.success(null),
      Failed() => const Result.failed('Failed to Top up'),
    };
  }
}

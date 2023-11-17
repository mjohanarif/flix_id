import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flix_id/data/firebase/firebase.dart';
import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/transaction.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  final firestore.FirebaseFirestore _firebaseFirestore;

  FirebaseTransactionRepository(
      {firestore.FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore =
            firebaseFirestore ?? firestore.FirebaseFirestore.instance;

  @override
  Future<Result<Transaction>> createTransaction({
    required Transaction transaction,
  }) async {
    firestore.CollectionReference<Map<String, dynamic>> documentReference =
        _firebaseFirestore.collection('transactions');

    try {
      final currentBalance =
          await FirebaseUserRepository().getUserBalance(uid: transaction.uid);
      if (currentBalance.isSuccess) {
        if (currentBalance.resultValue! - transaction.total >= 0) {
          await documentReference.doc(transaction.uid).set(
                transaction.toJson(),
              );

          var result = await documentReference.doc().get();

          if (result.exists) {
            await FirebaseUserRepository().updateUserBalance(
                uid: transaction.uid,
                balance: currentBalance.resultValue! - transaction.total);

            return Result.success(
              Transaction.fromJson(result.data()!),
            );
          } else {
            return const Result.failed(
              'Failed to create transaction data',
            );
          }
        } else {
          return const Result.failed('Insufficient balance');
        }
      } else {
        return const Result.failed(
          'Failed to create transaction data',
        );
      }
    } catch (e) {
      return const Result.failed(
        'Failed to create transaction data',
      );
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTransaction({
    required String uid,
  }) async {
    firestore.CollectionReference<Map<String, dynamic>> transaction =
        _firebaseFirestore.collection('transactions');

    try {
      final result = await transaction.where('uid', isEqualTo: uid).get();

      if (result.docs.isNotEmpty) {
        return Result.success(
          result.docs
              .map(
                (e) => Transaction.fromJson(e.data()),
              )
              .toList(),
        );
      } else {
        return const Result.success([]);
      }
    } catch (e) {
      return const Result.failed(
        'Failed to get user transactions',
      );
    }
  }
}

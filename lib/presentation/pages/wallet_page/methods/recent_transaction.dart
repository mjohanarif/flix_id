import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransactions(WidgetRef ref) => [
      const Text(
        'Recent Transactions',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      verticalSpaces(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => transactions.isEmpty
                ? []
                : (transactions
                      ..sort((a, b) =>
                          -a.transactionTime!.compareTo(b.transactionTime!)))
                    .map(
                    (transaction) => TransactionCard(transaction: transaction),
                  ),
            error: (error, stackTrace) => [],
            loading: () => [
              const CircularProgressIndicator(),
            ],
          ),
    ];

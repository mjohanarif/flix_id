import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecase/create_transaction/create_transaction_param.dart';
import 'package:flix_id/presentation/extensions/build_context_extension.dart';
import 'package:flix_id/presentation/extensions/int_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/booking_confirmation_page/methods/transaction_row.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecase/create_transaction_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id/presentation/widgets/back_navigation_bar.dart';
import 'package:flix_id/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({super.key, required this.transactionDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;

    transaction = transaction.copyWith(
      total: transaction.ticketAmount! * transaction.ticketPrice! +
          transaction.adminFee,
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
            child: Column(
              children: [
                BackNavigationBar(
                  'Booking Confirmation',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpaces(24),
                NetworkImageCard(
                  width: MediaQuery.of(context).size.width - 48,
                  height: (MediaQuery.of(context).size.width - 48) * 0.6,
                  borderRadius: 16,
                  imageUrl:
                      '${baseImageUrl('500')}/${movieDetail.backDrop ?? movieDetail.posterPath}',
                  boxFit: BoxFit.cover,
                ),
                verticalSpaces(24),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpaces(5),
                const Divider(color: ghostWhite),
                verticalSpaces(5),
                transactionRow(
                  title: 'Showing date',
                  value: DateFormat('EEEE, d MMMM y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          transaction.watchTime ?? 0)),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Theater',
                  value: '${transaction.theaterName}',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Seat Numbers',
                  value: transaction.seats.join(', '),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: '# of Tickets',
                  value: '${transaction.ticketAmount} ticket(s)',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Ticket Price',
                  value: '${transaction.ticketPrice?.toIDRFormatCurrency()}',
                  width: MediaQuery.of(context).size.width - 48,
                ),
                transactionRow(
                  title: 'Admin Fee',
                  value: transaction.adminFee.toIDRFormatCurrency(),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                const Divider(color: ghostWhite),
                transactionRow(
                  title: 'Total Price',
                  value: transaction.total.toIDRFormatCurrency(),
                  width: MediaQuery.of(context).size.width - 48,
                ),
                verticalSpaces(40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: backgroundColor,
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      int transactionTime =
                          DateTime.now().millisecondsSinceEpoch;

                      transaction = transaction.copyWith(
                        transactionTime: transactionTime,
                        id: 'flx-$transactionTime-${transaction.uid}',
                      );

                      CreateTransaction createTransaction =
                          ref.read(createTransactionProvider);

                      await createTransaction(
                              CreateTransactionParam(transaction: transaction))
                          .then((result) {
                        switch (result) {
                          case Success(value: _):
                            ref
                                .read(transactionDataProvider.notifier)
                                .refreshTransactionData();
                            ref
                                .read(userDataProvider.notifier)
                                .refreshUserData();
                            ref.read(routerProvider).pushNamed('main');
                          case Failed(:final message):
                            context.shohSnackbar(message);
                        }
                      });
                    },
                    child: const Text('Pay now'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/presentation/extensions/int_extension.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: transaction.title != 'Top up'
                        ? NetworkImage(
                            '${baseImageUrl('500')}${transaction.transactionImage}',
                          ) as ImageProvider
                        : const AssetImage('assets/topup.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE, d MMMM y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        transaction.transactionTime!,
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  verticalSpaces(5),
                  Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    transaction.title == 'Top up'
                        ? '+ ${(-transaction.total).toIDRFormatCurrency()}'
                        : transaction.total.toIDRFormatCurrency(),
                    style: TextStyle(
                      color: transaction.title == 'Top up'
                          ? const Color.fromARGB(255, 107, 237, 90)
                          : const Color(0xffeaa94e),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:intl/intl.dart';

extension IntExt on int {
  String toIDRFormatCurrency() =>
      NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
          .format(this);
}

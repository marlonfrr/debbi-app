import 'package:intl/intl.dart';

///
/// Turn this to extension
///

String formatPriceFromDouble(double price) {
  return "\$${NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0).format(price).trim()}";
}

import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static dateTimeDefault(int? input) {
    if (input == null) return '-';
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static date(int? input) {
    if (input == null) return '-';
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(input);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}

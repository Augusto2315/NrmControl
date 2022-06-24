import 'package:intl/intl.dart';

class Formats {
  static String getDateFormated(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

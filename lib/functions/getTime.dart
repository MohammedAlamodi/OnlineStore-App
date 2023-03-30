import 'package:intl/intl.dart';

getTime() {
  final String formattedDateTime =
  DateFormat('yyyy-MM-dd , kk:mm:ss').format(DateTime.now()).toString();
    return formattedDateTime;
}
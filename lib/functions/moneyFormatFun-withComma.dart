import 'package:intl/intl.dart';

moneyFormatWithComma(price){
  var formatter = NumberFormat('#,###,000');
  return formatter.format(price);
}
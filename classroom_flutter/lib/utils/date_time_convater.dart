import 'package:intl/intl.dart';

String getReadabelDate(String dateTime){
  return DateFormat.yMMMMd().format(DateTime.parse(dateTime));
}
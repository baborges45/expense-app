import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get toFormattedString {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

String convertDateToSave(String initialDate) {
  try {
    var inputDateFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputDateFormat.parse(initialDate);
    var outputFormat = DateFormat('dd/MM/yyyy');
    String outputDate = outputFormat.format(
      inputDate,
    );

    return outputDate;
  } catch (e) {
    return '';
  }
}

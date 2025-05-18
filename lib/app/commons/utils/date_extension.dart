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

String formatDate(String date) {
  try {
    final parsedDate = double.tryParse(date);
    if (parsedDate != null) {
      final dateTime = DateTime(1899, 12, 30).add(Duration(days: parsedDate.toInt()));
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }

    final dateTime = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  } catch (e) {
    return date;
  }
}

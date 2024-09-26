import 'package:intl/intl.dart';

class ParsingString {
  String formatTimeHHmm(String dateTime) {
    // Parsing string ke DateTime
    DateTime formatedDateTime = DateTime.parse(dateTime);

    // Membuat formatter untuk format "HH:mm"
    final DateFormat formatter = DateFormat('HH:mm');

    // Mengembalikan string yang diformat
    return formatter.format(formatedDateTime);
  }

  String formatFullName(String fullName) {
    String result = fullName.replaceAll(RegExp(r'\s+'), ' ');
    return result;
  }
}

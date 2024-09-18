import 'package:intl/intl.dart';

class ParsingDate {
  String formatTime(String dateTime) {
    // Parsing string ke DateTime
    DateTime formatedDateTime = DateTime.parse(dateTime);

    // Membuat formatter untuk format "HH:mm"
    final DateFormat formatter = DateFormat('HH:mm');

    // Mengembalikan string yang diformat
    return formatter.format(formatedDateTime);
  }
}

import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final _coinFormat = NumberFormat('#,###', 'tr_TR');
  static final _dateFormat = DateFormat('dd MMMM yyyy HH:mm', 'tr_TR');
  static final _shortDateFormat = DateFormat('dd.MM.yyyy', 'tr_TR');

  static String formatCoin(double amount) {
    return _coinFormat.format(amount.toInt());
  }

  static String formatCoinWithSign(double amount) {
    final formatted = _coinFormat.format(amount.abs().toInt());
    if (amount > 0) return '+$formatted';
    if (amount < 0) return '-$formatted';
    return formatted;
  }

  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  static String formatShortDate(DateTime date) {
    return _shortDateFormat.format(date);
  }

  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');

    // Try Turkish format: 90 + 10 digits
    if (cleaned.length == 12 && cleaned.startsWith('90')) {
      final number = cleaned.substring(2);
      return '+90 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6, 8)} ${number.substring(8)}';
    }

    // Generic international format: find dial code and format
    if (cleaned.length > 7) {
      // Try to insert a + and space after first 1-3 digit dial code
      for (final len in [1, 2, 3]) {
        if (cleaned.length > len) {
          final dialCode = cleaned.substring(0, len);
          final number = cleaned.substring(len);
          return '+$dialCode $number';
        }
      }
    }

    return '+$cleaned';
  }

  static String normalizePhone(String input) {
    String cleaned = input.replaceAll(RegExp(r'[^\d]'), '');
    if (input.startsWith('+')) {
      cleaned = input.substring(1).replaceAll(RegExp(r'[^\d]'), '');
    }
    return cleaned;
  }

  static String formatDurationTimer(Duration duration) {
    if (duration.isNegative) return 'Süresi Doldu';

    final days = duration.inDays;
    final hours = (duration.inHours % 24).toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    if (days > 0) {
      return '$days Gün $hours:$minutes:$seconds';
    }
    return '$hours:$minutes:$seconds';
  }
}

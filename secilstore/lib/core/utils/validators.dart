import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import '../models/country_code.dart';

class Validators {
  Validators._();

  static bool isValidPhone(String phone, CountryCode country) {
    try {
      final isoCode = IsoCode.fromJson(country.code);
      final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');

      if (cleaned.isEmpty) return false;

      // Parse national number with the given iso code.
      // This ensures global strict validation for any country.
      final parsed = PhoneNumber.parse(cleaned, callerCountry: isoCode);
      return parsed.isValid();
    } catch (_) {
      // Fallback to basic length validation if parser fails or country code is completely unknown
      final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
      if (cleaned.isEmpty) return false;
      return cleaned.length >= country.minLength &&
          cleaned.length <= country.maxLength;
    }
  }

  static bool isValidTurkishPhone(String phone) {
    return isValidPhone(phone, CountryCode.turkey);
  }

  static bool isValidOtp(String otp) {
    return otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp);
  }

  static String? phoneErrorText(String phone, {CountryCode? country}) {
    if (phone.isEmpty) return null;
    final c = country ?? CountryCode.turkey;
    if (!isValidPhone(phone, c)) {
      return 'Telefon numaranız hatalı.';
    }
    return null;
  }
}

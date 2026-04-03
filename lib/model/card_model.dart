class CardModel {
  final String id;
  final String cardHolderName;
  final String cardNumber; // last 4 digits only stored
  final String expiry;
  final String cardType; // Visa, Mastercard, Amex
  final bool isDefault;

  const CardModel({
    required this.id,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiry,
    required this.cardType,
    this.isDefault = false,
  });

  CardModel copyWith({bool? isDefault}) {
    return CardModel(
      id: id,
      cardHolderName: cardHolderName,
      cardNumber: cardNumber,
      expiry: expiry,
      cardType: cardType,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  String get maskedNumber => '•••• •••• •••• $cardNumber';
}

// ── Luhn Algorithm Validation ─────────────────────────────────────────────────
class CardValidator {
  // Luhn check
  static bool isValidLuhn(String number) {
    final digits = number.replaceAll(' ', '');
    if (digits.length < 13 || digits.length > 19) return false;
    int sum = 0;
    bool alternate = false;
    for (int i = digits.length - 1; i >= 0; i--) {
      int n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  // Detect card type from number
  static String detectType(String number) {
    final d = number.replaceAll(' ', '');
    if (d.startsWith('4')) return 'Visa';
    if (d.startsWith('5') || d.startsWith('2')) return 'Mastercard';
    if (d.startsWith('34') || d.startsWith('37')) return 'Amex';
    if (d.startsWith('6')) return 'Discover';
    return 'Card';
  }

  // Expiry format MM/YY and not expired
  static bool isValidExpiry(String expiry) {
    final parts = expiry.split('/');
    if (parts.length != 2) return false;
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || year == null) return false;
    if (month < 1 || month > 12) return false;
    final now = DateTime.now();
    final fullYear = 2000 + year;
    final expiryDate = DateTime(fullYear, month + 1);
    return expiryDate.isAfter(now);
  }

  // Format card number with spaces every 4 digits
  static String formatNumber(String input) {
    final digits = input.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  // Format expiry MM/YY
  static String formatExpiry(String input) {
    final digits = input.replaceAll('/', '');
    if (digits.length >= 2) {
      return '${digits.substring(0, 2)}/${digits.substring(2)}';
    }
    return digits;
  }
}

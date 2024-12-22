// models/massages.dart
class Massages {
  final String massage;
  final bool isSender;

  Massages({required this.massage, required this.isSender});

  factory Massages.fromJson(Map<String, dynamic> json) {
    return Massages(
      massage: json['message'] ?? '', // Default to empty string if no message field
      isSender: json['isSender'] ?? false, // Default to false if no isSender field
    );
  }
}

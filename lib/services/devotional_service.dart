import 'package:intl/intl.dart';

class DevotionalService {
  static final List<Map<String, String>> _devotionals = [
    { 'date': '2025-04-30', 'text': 'Devotional for April 30...' },
    { 'date': '2025-05-01', 'text': 'Devotional for May 1...' },
    // add more entries here
  ];

  static Future<String> getTodayDevotional() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final match = _devotionals.firstWhere(
      (d) => d['date'] == today,
      orElse: () => { 'text': 'No devotional for today.' },
    );
    return match['text']!;
  }
}
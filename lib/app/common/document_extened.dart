import 'package:appwrite/models.dart';
import 'package:darty_json_safe/darty_json_safe.dart';

extension ArcticleDcoument on Document {
  String? get getTitle => JSON(data)['data']['title'].stringValue;
  String? get getDate => DateTime.parse($createdAt).toLocal().toString();
  String? get getBackground {
    return Unwrap(getContent).map((e) {
      final result = e.match(r'!\[.*]\(.*\)');
      if (result == null) return null;
      final result1 = result.match(r'\(.*\)');
      if (result1 == null) return null;
      return result1.substring(1, result1.length - 1);
    }).value;
  }

  String? get getContent {
    return JSON(data)['data']['content'].string;
  }
}

extension on String {
  String? match(String match) {
    return Unwrap(RegExp(match))
        .map((e) => e.firstMatch(this))
        .map((e) => e.group(0))
        .value;
  }
}

import 'package:flutter/foundation.dart';

class TextProvider with ChangeNotifier {
  late String _text1;
  late String _text2;

  String get text1 => _text1;

  String get text2 => _text2;

  Future<void> setTexts(
      {required String value1, required String value2}) async {
    _text1 = value1;
    _text2 = value2;
    notifyListeners();
  }
}

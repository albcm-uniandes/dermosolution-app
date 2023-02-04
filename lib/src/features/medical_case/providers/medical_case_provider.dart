import 'package:flutter/foundation.dart';

class MedicalCaseInfo with ChangeNotifier {
  String _selectedItem = '';

  String get item => _selectedItem;

  void addItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

class LesionTypeModel with ChangeNotifier {
  late String _selectedItem;

  String get item => _selectedItem;

  void addItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }
}

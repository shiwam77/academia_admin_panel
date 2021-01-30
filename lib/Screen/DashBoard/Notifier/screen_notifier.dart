import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NavIndex extends ChangeNotifier {
  int _indexNumber = 0;

  getIndex() => _indexNumber;

  void changeIndex(int index) async {
    _indexNumber = index;
    notifyListeners();
  }
}

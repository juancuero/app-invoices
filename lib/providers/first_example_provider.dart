import 'package:flutter/material.dart';

class FirstExampleProvider extends ChangeNotifier {
  int _myValue = 0;

  FirstExampleProvider() {
    print("Inicializado....");
  }

  int get myValue {
    return _myValue;
  }

  set myValue(int i) {
    _myValue = i;
    notifyListeners();
  }
}

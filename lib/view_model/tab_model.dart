import 'package:flutter/foundation.dart';

class TabModel extends ChangeNotifier {
  int _currentTab = 0;

  int get currentTab => _currentTab;

  void setTab(newIndex) {
    _currentTab = newIndex;
    notifyListeners();
  }
}

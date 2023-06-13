import 'package:flutter/cupertino.dart';

class list_pro extends ChangeNotifier {
  List bookmark = [];

  add_bookmark(Url) {
    bookmark.add(Url);
    notifyListeners();
  }

  remove_bookmark(Url) {
    bookmark.remove(Url);
    notifyListeners();
  }

  int Group_val = 0;
}

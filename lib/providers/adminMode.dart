import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier{
  bool isAdmin = false;
  changIsAdmin(bool value){
    isAdmin = value;
    notifyListeners();
  }
}
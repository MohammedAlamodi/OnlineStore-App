import 'package:flutter/cupertino.dart';

class DropdownManage extends ChangeNotifier{
  String dropdownValue;
  setDropdownValue(String newValue){
    dropdownValue = newValue;
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';

class cartManage extends ChangeNotifier{
  // String dropdownValue;
  num num_of_cart_item=0;
  updataNum(){
    num_of_cart_item +=1;
    notifyListeners();
  }
}
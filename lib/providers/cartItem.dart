

import 'package:flutter/cupertino.dart';
import 'package:market_app/models/product.dart';

class CartItem extends ChangeNotifier{
  List<ProductData> products=[];

  addProduct(ProductData product){
    products.add(product);
    notifyListeners();
  }
  removeFromCart(int index){
    products.removeAt(index);
    notifyListeners();
  }
  clearCart(){
    products.clear();
    notifyListeners();
  }
}
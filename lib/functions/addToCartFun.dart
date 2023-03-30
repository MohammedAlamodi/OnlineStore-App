
import 'package:flutter/material.dart';
import 'package:market_app/providers/cartItem.dart';
import 'package:provider/provider.dart';


void addToCart(context, _product,_quantity) {
  CartItem cartItem = Provider.of<CartItem>(context, listen: false);

  bool productIsExist = false;
  var myProductInCart = cartItem.products;

  for (var productInCart in myProductInCart) {
    if (productInCart.proID == _product.proID) {
      productIsExist = true;
    }
  }
  if (productIsExist) {
    Scaffold.of(context).showBottomSheet((context) => SnackBar(content: Text('المنتج موجود بالفعل في العربه')));
  } else {
    _product.proQuantity = _quantity;
    cartItem.addProduct(_product);
    Scaffold.of(context).showBottomSheet((context) => SnackBar(content: Text('تم الاضافة الى العربه')));

  }
}
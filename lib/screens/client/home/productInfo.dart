import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/functions/addToCartFun.dart';
import 'package:market_app/models/product.dart';
import 'package:market_app/providers/cartItem.dart';
import 'package:market_app/providers/test.dart';
import 'package:provider/provider.dart';

import 'catrScreen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    ProductData _product = ModalRoute.of(context).settings.arguments;
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    num numOfCartItem = Provider.of<CartItem>(context).products.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Container(
              // height:
              // isPortrait ? _screenHeight * .1 : _screenHeight * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Badge(
                    position: BadgePosition.topEnd(end: 3),
                    animationDuration: Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '$numOfCartItem',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.pushNamed(context, CartScreen.id);
                        }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    height: _screenHeight * .28,
                    width: _screenWidth,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(_product.proLocation),
                    ),
                  ),
                  SizedBox(
                    height: _screenHeight * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'R.Y ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'janna'),
                          ),
                          Text(
                            '${_product.proPrice}',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'janna'),
                          ),
                          Text(
                            ' :السعر  ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'janna'),
                          ),
                        ],
                      ),
                      Text(
                        '${_product.proName}',
                        style: TextStyle(
                            color: kMainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'janna'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _screenHeight * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${_product.proDescription}',
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'janna'),
                          ),
                          Text(
                            '  :الوصف',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'janna'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Material(
                      color: kSecondaryColor,
                      child: GestureDetector(
                        onTap: () {
                          if (_quantity > 0) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        child: SizedBox(
                          child: Icon(Icons.remove),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: _screenWidth * .04,
                  ),
                  ClipOval(
                    child: Material(
                      color: kSecondaryColor,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: SizedBox(
                          child: Icon(Icons.add),
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: _screenWidth * .05,
              ),
              Column(
                children: [
                  Text(
                    'الكميه',
                    style: TextStyle(fontFamily: 'Janna'),
                  ),
                  Badge(
                    // position: BadgePosition.topEnd(end: 3),
                    animationDuration: Duration(milliseconds: 500),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '$_quantity',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: _screenHeight * .02,
          ),
          ButtonTheme(
            minWidth: _screenWidth,
            height: _screenHeight * .1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Builder(
              builder: (context) => MaterialButton(
                onPressed: () {
                  addToCart(context, _product,_quantity);

                },
                color: kMainColor,
                child: Text(
                  'إضافه الى السلة',
                  style: TextStyle(
                      color: Colors.white, fontSize: 17, fontFamily: 'Janna'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



}

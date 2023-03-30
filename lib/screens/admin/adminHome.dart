import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_app/customWidgets/custom%20AppLogo.dart';
import 'package:market_app/customWidgets/custom%20RaisedButton.dart';
import 'package:market_app/screens/admin/addProduct.dart';
import 'package:market_app/screens/admin/manageProduct.dart';

import 'ordersScreen.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: CustomAppLogo(
                textColor: Color(0xFF285279),
              )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'لوحة تحكم الادمن ',
                  style: TextStyle(
                    fontFamily: 'Janna',
                  ),
                ),
                CustomRaisedButton(
                  name: 'أضافة منتج جديد',
                  onPress: () {
                    Navigator.pushNamed(context, AddProduct.id);
                  },
                ),
                CustomRaisedButton(name: 'ادارة المنتجات', onPress: () {
                  Navigator.pushNamed(context, ManageProducts.id);
                }),
                CustomRaisedButton(name: 'طلبات المنتجات', onPress: () {
                  Navigator.pushNamed(context, OrdersScreen.id);
                }),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:market_app/providers/adminMode.dart';
import 'package:market_app/providers/cartItem.dart';
import 'package:market_app/providers/dropdownManage.dart';
import 'package:market_app/providers/test.dart';
import 'package:market_app/screens/admin/addProduct.dart';
import 'package:market_app/screens/admin/adminHome.dart';
import 'package:market_app/screens/admin/editProduct.dart';
import 'package:market_app/screens/admin/manageProduct.dart';
import 'package:market_app/screens/admin/orderDetails.dart';
import 'package:market_app/screens/admin/ordersScreen.dart';
import 'package:market_app/screens/client/home/catrScreen.dart';
import 'package:market_app/screens/client/home/home_switch.dart';
import 'package:market_app/screens/client/home/productInfo.dart';
import 'package:market_app/screens/login_screen.dart';
import 'package:market_app/screens/signup_screen.dart';
import 'package:market_app/services/locator.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminMode>(create: (context)=>AdminMode(),),
        ChangeNotifierProvider<DropdownManage>(create: (context)=>DropdownManage(),),
        ChangeNotifierProvider<cartManage>(create: (context)=>cartManage(),),
        ChangeNotifierProvider<CartItem>(create: (context)=>CartItem(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: 'Janna',
      ),
        initialRoute:  LoginScreen.id,
        routes:
        {
          LoginScreen.id :(context) => LoginScreen(),
          SignUpScreen.id:(context) => SignUpScreen(),
          HomeSwitch.id:(context) => HomeSwitch(),
          AdminHome.id:(context) => AdminHome(),
          AddProduct.id:(context) => AddProduct(),
          ManageProducts.id:(context) => ManageProducts(),
          EditProduct.id:(context) => EditProduct(),
          ProductInfo.id:(context) => ProductInfo(),
          CartScreen.id:(context) => CartScreen(),
          OrdersScreen.id:(context) => OrdersScreen(),
          OrderDetails.id:(context) => OrderDetails(),
          // mmm.id:(context) => mmm(),
        },
      ),
    );
  }
}

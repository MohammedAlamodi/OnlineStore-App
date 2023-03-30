import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/providers/cartItem.dart';
import 'package:market_app/screens/client/home/HomePage.dart';
import 'package:market_app/screens/client/offersPage.dart';
import 'package:market_app/screens/client/profile/profilePage.dart';
import 'package:provider/provider.dart';
import 'catrScreen.dart';

class HomeSwitch extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomeSwitchState createState() => _HomeSwitchState();
}

class _HomeSwitchState extends State<HomeSwitch> {
  // final _auth = Auth();
  // Firebase _loggedUser;
  // final _store = Store();
  int _btmBarIndex = 0;
  String pageTitle;

  @override
  // ignore: must_call_super
  void initState() {
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    num _screenHeight = MediaQuery.of(context).size.height;
    num _screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    num numOfCartItem = Provider.of<CartItem>(context).products.length;
    Widget child;
    switch (_btmBarIndex) {
      case 0:
        pageTitle = 'تصفح';
        child = HomePage();
        break;
      case 1:
        pageTitle = ' عروض';
        child = OffersPage();
        break;
      case 2:
        pageTitle = 'حسابي';
        child = ProfilePage();
        break;
    }
    return Stack(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              body: SizedBox.expand(child: child),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: kUnActiveColor,
                currentIndex: _btmBarIndex,
                fixedColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _btmBarIndex = value;
                    print('botom is $_btmBarIndex');
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    // ignore: deprecated_member_use
                    label: 'الرئيسيه',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.local_offer_outlined),
                      // ignore: deprecated_member_use
                      label: 'عروض'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      // ignore: deprecated_member_use
                      label: 'حسابي'),
                ],
              ),
            ),
          ),
        ),
        _btmBarIndex != 2
            ? Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                  child: Container(
                    height:
                        isPortrait ? _screenHeight * .06 : _screenHeight * .1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Text(
                          '$pageTitle',
                          style: TextStyle(
                              fontSize: _screenHeight * .035,
                              fontWeight: FontWeight.bold,),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Text('')
      ],
    );
  }

  void getCurrentUser() {
    setState(() {
      // _loggedUser = _auth.getUser();
    });
  }
}

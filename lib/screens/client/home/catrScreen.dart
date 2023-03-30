import 'package:badges/badges.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/controller/userController.dart';
import 'package:market_app/functions/getTime.dart';
import 'package:market_app/functions/moneyFormatFun-withComma.dart';
import 'package:market_app/functions/moneyFormatFun-withOutComma.dart';
import 'package:market_app/models/product.dart';
import 'package:market_app/models/userModel.dart';
import 'package:market_app/providers/cartItem.dart';
import 'package:market_app/services/locator.dart';
import 'package:market_app/services/store.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _store = Store();
    UserModel _currentUser = locator.get<UserController>().currentUser;

    List<ProductData> _product = Provider.of<CartItem>(context).products;
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    TextStyle titleStyle = TextStyle(color: Colors.grey, fontFamily: 'Janna');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'العربه',
              style: TextStyle(fontFamily: 'Janna', color: Colors.black),
            )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: LayoutBuilder(builder: (context, constrains) {
                if (_product.isNotEmpty) {
                  return ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('العناصر', style: titleStyle),
                      ),
                      for (var index = 0; index < _product.length; index++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: isPortrait
                                ? _screenHeight * .23
                                : _screenHeight * .30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: _screenHeight * .15 / 2,
                                    backgroundImage: NetworkImage(
                                        _product[index].proLocation),
                                  ),
                                  SizedBox(
                                    width: _screenWidth * .01,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_product[index].proName}',
                                        style: TextStyle(fontFamily: 'Janna'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('السعر: ', style: titleStyle),
                                          Text(
                                            '${_product[index].proPrice} R.Y',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('الكميه: ', style: titleStyle),
                                          ClipOval(
                                            child: Material(
                                              color: kSecondaryColor,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _product[index]
                                                        .proQuantity++;
                                                  });
                                                },
                                                child: SizedBox(
                                                  child: Icon(Icons.add),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: _screenWidth * .015,
                                          ),
                                          Badge(
                                            // position: BadgePosition.topEnd(end: 3),
                                            animationDuration:
                                                Duration(milliseconds: 500),
                                            animationType:
                                                BadgeAnimationType.slide,
                                            badgeContent: Text(
                                              '${_product[index].proQuantity}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: _screenWidth * .015,
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: kSecondaryColor,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (_product[index]
                                                          .proQuantity >
                                                      1) {
                                                    setState(() {
                                                      _product[index]
                                                          .proQuantity--;
                                                    });
                                                  }
                                                },
                                                child: SizedBox(
                                                  child: Icon(Icons.remove),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('المجموع الفرعي: ',
                                              style: titleStyle),
                                          Text(
                                            '${moneyFormatWithComma(int.parse(moneyFormatSetWithOutComma(_product[index].proPrice)) * _product[index].proQuantity)}',
                                            style:
                                                TextStyle(fontFamily: 'janna'),
                                          ),
                                          Text(
                                            ' R.Y ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'janna'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _screenHeight * .01,
                              ),
                              Expanded(
                                child: ButtonTheme(
                                  height: double.infinity,
                                  minWidth: double.infinity,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Builder(
                                    builder: (context) => MaterialButton(
                                      onPressed: () {
                                        Provider.of<CartItem>(context,
                                                listen: false)
                                            .removeFromCart(index);
                                        Scaffold.of(context).showBottomSheet(
                                            (context) => SnackBar(
                                                content: Text('تم الحذف')));
                                      },
                                      color: kMainColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'الأزاله من السلة',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Janna'),
                                          ),
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text('تفاصيل الطلب', style: titleStyle),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'المجموع الفرعي: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('${getTotalPrice(_product)} R.Y'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تكلفة الشحن: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('0 R.Y'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الضريبه: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('0 R.Y'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'المجموع: ',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text('${getTotalPrice(_product)} R.Y'),
                                ],
                              ),
                              GestureDetector(
                                child: Text(
                                  'إفراغ سلة التسوق',
                                  style: TextStyle(
                                      color: kMainColor, fontFamily: 'Janna'),
                                ),
                                onTap: () {
                                  dialogRemoveCart(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _screenHeight * .03,
                      )
                    ],
                  );

                  // return Container(
                  //   height: _screenHeight -
                  //       (_screenHeight * .1) -
                  //       appBarHeight -
                  //       statusBarHeight,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(right: 10),
                  //         child: Text('العناصر',style: TextStyle(color: Colors.grey,fontFamily: 'Janna'),),
                  //       ),
                  //       Expanded(
                  //         child: ListView.builder(
                  //             itemCount: _product.length,
                  //             itemBuilder: (context, index) {
                  //               return Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Container(
                  //                   height: isPortrait
                  //                       ? _screenHeight * .23
                  //                       : _screenHeight * .30,
                  //                   decoration: BoxDecoration(
                  //                     border: Border.all(color: Colors.black12),
                  //                     borderRadius: BorderRadius.circular(10),
                  //                   ),
                  //                   child: Column(
                  //                     children: [
                  //                       Row(
                  //                         children: [
                  //                           CircleAvatar(
                  //                             radius: _screenHeight * .15 / 2,
                  //                             backgroundImage: NetworkImage(
                  //                                 _product[index].proLocation),
                  //                           ),
                  //                           SizedBox(
                  //                             width: _screenWidth * .01,
                  //                           ),
                  //                           Column(
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.start,
                  //                             children: [
                  //                               Text(
                  //                                 '${_product[index].proName}',
                  //                                 style: TextStyle(fontFamily: 'Janna'),
                  //                               ),
                  //                               Row(
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.end,
                  //                                 children: [
                  //                                   Text(
                  //                                     'السعر: ',
                  //                                     style: TextStyle(
                  //                                         color: Colors.grey,
                  //                                         fontFamily: 'janna'),
                  //                                   ),
                  //                                   Text(
                  //                                     '${_product[index].proPrice}',
                  //                                     style: TextStyle(
                  //                                         color: Colors.red,
                  //                                         fontFamily: 'janna'),
                  //                                   ),
                  //                                   Text(
                  //                                     ' R.Y ',
                  //                                     style: TextStyle(
                  //                                         color: Colors.black,
                  //                                         fontFamily: 'janna'),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                               Row(
                  //                                 children: [
                  //                                   Text(
                  //                                     'الكميه: ',
                  //                                     style: TextStyle(
                  //                                         color: Colors.grey,
                  //                                         fontFamily: 'Janna'),
                  //                                   ),
                  //
                  //                                   ClipOval(
                  //                                     child: Material(
                  //                                       color: kSecondaryColor,
                  //                                       child: GestureDetector(
                  //                                         onTap: () {
                  //                                           setState(() {
                  //                                             _product[index]
                  //                                                 .proQuantity++;
                  //                                           });
                  //                                         },
                  //                                         child: SizedBox(
                  //                                           child: Icon(Icons.add),
                  //                                           height: 25,
                  //                                           width: 25,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                   SizedBox(width: _screenWidth*.015,),
                  //                                   Badge(
                  //                                     // position: BadgePosition.topEnd(end: 3),
                  //                                     animationDuration:
                  //                                         Duration(milliseconds: 500),
                  //                                     animationType:
                  //                                         BadgeAnimationType.slide,
                  //                                     badgeContent: Text(
                  //                                       '${_product[index].proQuantity}',
                  //                                       style: TextStyle(
                  //                                           color: Colors.white),
                  //                                     ),
                  //                                   ),
                  //                                   SizedBox(width: _screenWidth*.015,),
                  //                                   ClipOval(
                  //                                     child: Material(
                  //                                       color: kSecondaryColor,
                  //                                       child: GestureDetector(
                  //                                         onTap: () {
                  //                                           if (_product[index]
                  //                                               .proQuantity >
                  //                                              1) {
                  //                                             setState(() {
                  //                                               _product[index]
                  //                                                   .proQuantity--;
                  //                                             });
                  //                                           }
                  //                                         },
                  //                                         child: SizedBox(
                  //                                           child: Icon(Icons.remove),
                  //                                           height: 25,
                  //                                           width: 25,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                               Row(
                  //                                 children: [
                  //                                   Text(
                  //                                     'المجموع الفرعي: ',
                  //                                     style: TextStyle(
                  //                                         color: Colors.grey,
                  //                                         fontFamily: 'janna'),
                  //                                   ),
                  //
                  //                                   Text(
                  //                                     '${int.parse(moneyFormat(_product[index].proPrice))*_product[index].proQuantity}',
                  //                                     style: TextStyle(
                  //
                  //                                         fontFamily: 'janna'),
                  //                                   ),
                  //                                   Text(
                  //                                     ' R.Y ',
                  //                                     style: TextStyle(
                  //                                         color: Colors.black,
                  //                                         fontFamily: 'janna'),
                  //                                   ),
                  //                                 ],
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       SizedBox(
                  //                         height: _screenHeight * .01,
                  //                       ),
                  //                       Expanded(
                  //                         child: ButtonTheme(
                  //                           height: double.infinity,
                  //                           minWidth: double.infinity,
                  //                           shape: RoundedRectangleBorder(
                  //                             borderRadius: BorderRadius.only(
                  //                                 bottomLeft: Radius.circular(10),
                  //                                 bottomRight: Radius.circular(10)),
                  //                           ),
                  //                           child: Builder(
                  //                             builder: (context) => RaisedButton(
                  //                               onPressed: () {
                  //                                 Provider.of<CartItem>(context,
                  //                                         listen: false)
                  //                                     .removeFromCart(index);
                  //                                 Scaffold.of(context).showSnackBar(
                  //                                     SnackBar(
                  //                                         content: Text('تم الحذف')));
                  //                               },
                  //                               color: kMainColor,
                  //                               child: Row(
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Text(
                  //                                     'الأزاله من السلة',
                  //                                     style: TextStyle(
                  //                                         color: Colors.white,
                  //                                         fontFamily: 'Janna'),
                  //                                   ),
                  //                                   Icon(
                  //                                     Icons.delete,
                  //                                     color: Colors.white,
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             }),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(right: 10),
                  //         child: Text('العناصر',style: TextStyle(color: Colors.grey,fontFamily: 'Janna'),),
                  //       ),
                  //     ],
                  //   ),
                  // );
                } else {
                  return Container(
                      height: _screenHeight -
                          (_screenHeight * .1) -
                          appBarHeight -
                          statusBarHeight,
                      child: Center(
                          child: Text(
                        'لايوجد لديك عناصر في العربه',
                        style: TextStyle(fontFamily: 'Janna'),
                      )));
                }
              }),
            ),
          ),
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: _screenWidth,
              height: _screenHeight * .1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Builder(
                builder: (context) => MaterialButton(
                  onPressed: () {
                    dialogConfirmOrder(_product, context);
                  },
                  color: kSecondaryColor,
                  child: Text(
                    'إكمال عملية الشراء',
                    style: TextStyle(
                        color: kMainColor, fontSize: 17, fontFamily: 'Janna'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void dialogRemoveCart(context) async {
    // var price = getTotalPrice(products);
    AlertDialog alertDialog = AlertDialog(
      title: Center(child: Text('تحذير')),
      content: Text('هل تريد حذف سلة التسوق الخاصه بك'),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'الغاء الامر',
            style: TextStyle(color: Colors.black),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Provider.of<CartItem>(context).products.clear();
          },
          child: Text(
            'حسناً',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  void dialogConfirmOrder(List<ProductData> products, context) async {
    UserModel _currentUser = locator.get<UserController>().currentUser;
    var totalPrice = getTotalPrice(products);
    totalPrice = moneyFormatSetWithOutComma(totalPrice);
    totalPrice = double.tryParse(totalPrice);
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              String formattedDateTime = getTime();
              _store.storeOrders({
                kTotalPrice: totalPrice,
                kUserName: _currentUser.userInfo[0],
                kUserPersonalImageUrl: _currentUser.personalImageUrl,
                kTimeOfSendingTheOrder: formattedDateTime,
              }, products);

              // Scaffold.of(context)
              //     .showSnackBar(SnackBar(content: Text('تم ارسال الطلب')));
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false).clearCart();
            } catch (ex) {
              // Scaffold.of(context)
              //     .showSnackBar(SnackBar(content: Text(ex.message)));
              Navigator.pop(context);
              print(ex.message);
            }
          },
          child: Text('تأكيد'),
        )
      ],
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'المجموع: ',
              style: TextStyle(color: Colors.grey),
            ),
            Text('$totalPrice R.Y'),
          ],
        ),
      ),
      title: Center(child: Text('تأكيد ارسال الطلب')),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotalPrice(List<ProductData> products) {
    double price = 0.0;

    for (var product in products) {
      var p = product.proPrice;
      p = moneyFormatSetWithOutComma(p);
      price += product.proQuantity * double.tryParse(p);
    }
    var priceWithComma = moneyFormatWithComma(price);
    return priceWithComma;
  }
}

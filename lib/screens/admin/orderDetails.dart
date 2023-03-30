import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/functions/moneyFormatFun-withComma.dart';
import 'package:market_app/functions/moneyFormatFun-withOutComma.dart';
import 'package:market_app/models/Order.dart';
import 'package:market_app/models/product.dart';
import 'package:market_app/screens/client/profile/getAvatarPhoto.dart';
import 'package:market_app/services/store.dart';

import '../../constants.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double _appBarHeight = AppBar().preferredSize.height;
    final double _statusBarHeight = MediaQuery.of(context).padding.top;
    TextStyle titleStyle =
        TextStyle(color: Colors.black38, fontFamily: 'Janna');

    Order _order = ModalRoute.of(context).settings.arguments;
    String documentId = _order.documentId;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadOrdersDetails(documentId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductData> _products = [];
                for (var doc in snapshot.data.docs) {
                  Map<String, dynamic> data = doc.data();
                  _products.add(ProductData(
                    data[kProductQuantity],
                    doc.id,
                    data[kProductName],
                    data[kProductPrice],
                    data[kProductDescription],
                    data[kProductCategory],
                    data[kProductLocation],
                  ));
                }
                return Column(
                  children: [
                    SizedBox(
                      height: _statusBarHeight,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      color: kSecondaryColor,
                      width: double.infinity,
                      height: _appBarHeight,
                      child: Text(
                        'طلبية: ${_order.userName}',
                        style: TextStyle(
                            fontSize: isPortrait
                                ? _screenHeight * .03
                                : _screenWidth * .025,
                            fontFamily: 'Janna'),
                      ),
                    ),
                    Container(
                      color: kSecondaryColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: _screenWidth * .02,
                              ),
                              GetUserAvatar(
                                avatarUrl: _order.userPersonalImageUrl,
                              ),
                              SizedBox(
                                width: _screenWidth * .05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('مُرسل الطلبيه: ',
                                          style: titleStyle),
                                      Text(
                                        ' ${_order.userName}',
                                        style: TextStyle(
                                          fontFamily: 'Janna',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('إجمالي سعر الطلبيه: ',
                                          style: titleStyle),
                                      Text(
                                        '${moneyFormatWithComma(_order.totalPrice)}',
                                        style: TextStyle(
                                          fontFamily: 'Janna',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('تاريخ الارسال: ',
                                          style: titleStyle),
                                      Text(
                                        '${_order.timeOfSendingTheOrder}',
                                        style: TextStyle(
                                          fontFamily: 'Janna',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: _screenHeight * .02,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                                        _products[index].proLocation),
                                  ),
                                  SizedBox(
                                    width: _screenWidth * .01,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_products[index].proName}',
                                        style: TextStyle(fontFamily: 'Janna'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('السعر: ', style: titleStyle),
                                          Text(
                                            '${_products[index].proPrice} R.Y',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('الكميه: ', style: titleStyle),
                                          Badge(
                                            // position: BadgePosition.topEnd(end: 3),
                                            animationDuration:
                                                Duration(milliseconds: 500),
                                            animationType:
                                                BadgeAnimationType.slide,
                                            badgeContent: Text(
                                              '${_products[index].proQuantity}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('المجموع الفرعي: ',
                                              style: titleStyle),
                                          Text(
                                            '${moneyFormatWithComma(int.parse(moneyFormatSetWithOutComma(_products[index].proPrice)) * _products[index].proQuantity)}',
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
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: kMainColor,
                  semanticsLabel: 'ddd',
                  semanticsValue: 'ddddf',
                ));
              }
            }),
      ),
    );
  }
}

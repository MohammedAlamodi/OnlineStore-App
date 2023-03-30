import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/models/Order.dart';
import 'package:market_app/screens/admin/orderDetails.dart';
import 'package:market_app/services/store.dart';

import '../../constants.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double _appBarHeight = AppBar().preferredSize.height;
    final double _statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Center(
      //     child: Text('الطلبات',style: TextStyle(
      //       color: Colors.black,
      //       fontFamily: 'Janna'
      //     ),),
      //   ),
      // ),
      body: Column(
        children: [
          SizedBox(height: _statusBarHeight,),
          Container(
            color: Colors.white,
            height: _appBarHeight,
            child:  Center(
              child: Text('الطلبات',style: TextStyle(
                  fontSize: isPortrait? _screenHeight*.035:_screenWidth*.03,
                      color: Colors.black,
                      fontFamily: 'Janna'
                    ),),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _store.loadOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Order> orders = [];
                    for (var doc in snapshot.data.docs) {
                      Map<String, dynamic> data = doc.data();
                      orders.add(Order(
                        doc.id,
                        data[kTotalPrice],
                        data[kUserName],
                        data[kUserPersonalImageUrl],
                        data[kTimeOfSendingTheOrder],
                      ));
                    }
                    return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) =>
                           Padding(
                             padding: const EdgeInsets.all(8),
                             child: GestureDetector(
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   color: kSecondaryColor,
                                 ),
                                 child: Column(
                                   children: [
                                     Text(' اجمالي مبلغ الطلب: ${orders[index].totalPrice}',
                                       style: TextStyle(
                                         fontFamily: 'Janna'
                                       ),
                                     ),
                                     Text(' مُرسل الطلب: ${orders[index].userName??"محمد"}',
                                       style: TextStyle(
                                           fontFamily: 'Janna'
                                       ),),
                                     Text('  وقت إرسال الطلب:  ${orders[index].timeOfSendingTheOrder}',
                                       style: TextStyle(
                                           fontFamily: 'Janna'
                                       ),),
                                   ],
                                 ),
                               ),
                             ),
                           ));
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kMainColor,
                      semanticsLabel: 'انتظر من فضلك',
                    ));
                  }
                }),
          ),
        ],
      ),
    );
  }
}

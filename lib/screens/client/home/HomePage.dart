import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/functions/addToCartFun.dart';
import 'package:market_app/models/product.dart';
import 'package:market_app/providers/test.dart';
import 'package:market_app/screens/client/home/productInfo.dart';
import 'package:market_app/services/store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = Store();

  int _tabBarIndex = 0;
  int _quantity = 1;


  

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: kMainColor,
            onTap: (value) {
              setState(() {
                _tabBarIndex = value;
              });
            },
            tabs: [
              Text(
                'المنتجات',
                style: TextStyle(
                  fontFamily: 'Janna',
                  color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                  fontSize: _tabBarIndex == 0 ? 16 : null,
                ),
              ),
              Text(
                'الاكثر مبيعاً',
                style: TextStyle(
                  fontFamily: 'Janna',
                  color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                  fontSize: _tabBarIndex == 1 ? 16 : null,
                ),
              ),
              Text(
                'المفضله',
                style: TextStyle(
                  fontFamily: 'Janna',
                  color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                  fontSize: _tabBarIndex == 2 ? 16 : null,
                ),
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: [isLandscape?productViewLandscape():productView(), Center(child: Text('الأكثر مبيعاً')), Text('gg') ],
        ),
      ),
    );
  }

  List<String> _categories = [
    'الكل',
    'أزياء الرجال',
    'أزياء نسائيه',
    'ساعات وشنط وأكسسوارات',
  ];

  String isSelectedCategory = 'الكل';

  List<ProductData> productsAfterCatog = [];
  Widget productView() {
    num _screenHeight = MediaQuery.of(context).size.height;
    num _screenWidth = MediaQuery.of(context).size.width;
    // var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      children: [
        // FutureBuilder<List<String>>(
        //     future: _store.loadCategory(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         if(_categories.isEmpty){
        //           for (var doc in snapshot.data) {
        //             _categories.add(doc);
        //           }
        //         }
        //         return
        Container(
          height: _screenHeight * .065 ,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in _categories)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.5, vertical: 7),
                    child: GestureDetector(
                      child: Container(
                        // height: 40,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .06,
                              ),
                              Text(
                                '$i',
                                style: TextStyle(
                                    fontFamily: 'Janna',
                                    color: i == isSelectedCategory
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .06,
                              ),
                            ],
                          ),
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: i == isSelectedCategory
                                    ? kSecondaryColor
                                    : Colors.black12),
                            borderRadius: BorderRadius.circular(30),
                            color: i == isSelectedCategory
                                ? kMainColor
                                : Colors.white,
                          )),
                      onTap: () {
                        setState(() {
                          isSelectedCategory = i;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),

        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _store.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductData> _products = [];
                for (var doc in snapshot.data.docs) {
                  Map<String, dynamic> data = doc.data();
                  _products.add(ProductData(
                    null,
                      doc.id,
                      data[kProductName],
                      data[kProductPrice],
                      data[kProductDescription],
                      data[kProductCategory],
                      data[kProductLocation]));
                }
                var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
                productsAfterCatog = [..._products];
                _products.clear();
                // ignore: unrelated_type_equality_checks
                if (isSelectedCategory == _categories[0]) {
                  for (var singlProduct in productsAfterCatog) {
                    _products.add(singlProduct);
                  }
                } else {
                  for (var singlProduct in productsAfterCatog) {
                    if (singlProduct.proCategory == isSelectedCategory) {
                      _products.add(singlProduct);
                    }
                  }
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .8),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductInfo.id,arguments: _products[index]);
                        },
                      child: Material(
                        color: Colors.white,
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                bottom:
                                MediaQuery.of(context).size.height * .05,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Image(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                        _products[index].proLocation),
                                  ),
                                )),
                            Positioned(
                              bottom: 0,
                              child: Opacity(
                                //تخلي الوجت الي تحتها شفافه بحيث تجيب الي وراها
                                opacity: .7,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: 60,
                                  color: kSecondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _products[index].proName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Janna'),
                                        ),
                                        Text(
                                          '${_products[index].proPrice} R.Y',
                                          style: TextStyle(fontFamily: 'Janna'),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            addToCart(context, _products[index],_quantity);
                                          },
                                          child: Container(
                                            width: _screenWidth*.415,
                                            child: Center(child: Text('إضافة الى السلة', style: TextStyle(fontFamily: 'Janna',color: kMainColor))),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kMainColor),
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: _products.length,
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kMainColor,
                      semanticsLabel: 'انتظر من فضلك',
                    ));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget productViewLandscape() {
    num _screenHeight = MediaQuery.of(context).size.height;
    num _screenWidth = MediaQuery.of(context).size.width;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    // var isisLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return
      // FutureBuilder<List<String>>(
      //     future: _store.loadCategory(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         if(_categories.isEmpty){
      //           for (var doc in snapshot.data) {
      //             _categories.add(doc);
      //           }
      //         }
      //         return
      Row(
        children: [
          Container(
            width: _screenWidth*.34,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: [
                  for (var i in _categories)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.5, vertical: 7),
                      child: GestureDetector(
                        child: Container(
                            alignment: Alignment.center,
                            // height: 40,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                '$i',
                                style: TextStyle(
                                    fontFamily: 'Janna',
                                    color: i == isSelectedCategory
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),


                            // color: Colors.white,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: i == isSelectedCategory
                                      ? kSecondaryColor
                                      : Colors.black12),
                              borderRadius: BorderRadius.circular(20),
                              color: i == isSelectedCategory
                                  ? kMainColor
                                  : Colors.white,
                            )),
                        onTap: () {
                          setState(() {
                            isSelectedCategory = i;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _store.loadProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ProductData> _products = [];
                  for (var doc in snapshot.data.docs) {
                    Map<String, dynamic> data = doc.data();
                    _products.add(ProductData(
                      null,
                        doc.id,
                        data[kProductName],
                        data[kProductPrice],
                        data[kProductDescription],
                        data[kProductCategory],
                        data[kProductLocation]));
                  }
                  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
                  productsAfterCatog = [..._products];
                  _products.clear();
                  // ignore: unrelated_type_equality_checks
                  if (isSelectedCategory == _categories[0]) {
                    for (var singlProduct in productsAfterCatog) {
                      _products.add(singlProduct);
                    }
                  } else {
                    for (var singlProduct in productsAfterCatog) {
                      if (singlProduct.proCategory == isSelectedCategory) {
                        _products.add(singlProduct);
                      }
                    }
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: .8),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ProductInfo.id,arguments: _products[index]);
                        },
                        child: Material(
                          color: Colors.white,
                          elevation: 2,
                          borderRadius: BorderRadius.circular(8.0),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  bottom:
                                  MediaQuery.of(context).size.height * .05,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          _products[index].proLocation),
                                    ),
                                  )),
                              Positioned(
                                bottom: 0,
                                child: Opacity(
                                  //تخلي الوجت الي تحتها شفافه بحيث تجيب الي وراها
                                  opacity: .7,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // height: 60,
                                    color: kSecondaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _products[index].proName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Janna'),
                                          ),
                                          Text(
                                            '\$ ${_products[index].proPrice}',
                                            style: TextStyle(fontFamily: 'Janna'),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              addToCart(context, _products[index],_quantity);
                                            },
                                            child: Container(
                                                width: _screenWidth*.172,
                                                child: Center(child: Text('إضافة الى السلة', style: TextStyle(fontFamily: 'Janna',color: kMainColor))),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kMainColor),
                                                  borderRadius: BorderRadius.circular(10),
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: _products.length,
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kMainColor,
                        semanticsLabel: 'انتظر من فضلك',
                      ));
                }
              },
            ),
          ),
        ],
      );
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////

}

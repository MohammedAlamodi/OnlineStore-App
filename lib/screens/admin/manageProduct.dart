import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/models/product.dart';
import 'package:market_app/screens/admin/editProduct.dart';
import 'package:market_app/services/store.dart';

class ManageProducts extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) async {
                    double detailsX = details.globalPosition.dx;
                    double detailsY = details.globalPosition.dy;
                    double detailsX2 =
                        MediaQuery.of(context).size.width - detailsX;
                    double detailsY2 =
                        MediaQuery.of(context).size.height - detailsY;
                    await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            detailsX, detailsY, detailsX2, detailsY2),
                        items: [
                          MyPopupMenuItem(
                              child: Text('تعديل'),
                              onClick: () {
                                Navigator.pushNamed(context, EditProduct.id);
                              }),
                          MyPopupMenuItem(
                              child: Text('حذف'),
                              onClick: () {
                                _store.deleteProduct(_products[index].proID);
                                Navigator.pop(context);
                              }),
                        ]);
                  },
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                            bottom: MediaQuery.of(context).size.height * .05,
                            child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(_products[index].proLocation),
                            )),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            //تخلي الوجت الي تحتها شفافه بحيث تجيب الي وراها
                            opacity: .7,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _products[index].proName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('\$ ${_products[index].proPrice}')
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
    );
  }
}

// بنينا الPopupMenuItem علشان موضوع الضغط على احد الItem الي في المنيوو
class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  MyPopupMenuItem({@required this.child, @required this.onClick})
      : super(child: child); // MyPopupMenuItemStatتبعثها الى ال
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemStat();
  }
}

class MyPopupMenuItemStat<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}

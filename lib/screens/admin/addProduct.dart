import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:image_picker/image_picker.dart';
import 'package:market_app/customWidgets/custom%20textField.dart';
import 'package:market_app/models/product.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:market_app/providers/dropdownManage.dart';
import 'package:market_app/services/store.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name, _price, _dropdownValue, _description, _imageURL;
  String imagePhat = '';
  bool isThereAnImage = false;
  File imageFromGal;
  final _store = Store();
  List<String> _categories = [];

  // String dropdownValue;
  // List<String> _listOfCategory = [];

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<List<String>>(
          future: _store.loadCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (_categories.isEmpty) {
                for (var doc in snapshot.data) {
                  _categories.add(doc);
                }
              }
              // print('${_categories[1]}');
              // Provider.of<DropdownManage>(context).setDropdownValue(_categories[0]);
              return Form(
                key: _globalKey,
                child: ProgressHUD(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: _screenWidth * 0.12,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'أضافة منتج جديد',
                          style: TextStyle(
                            fontFamily: 'Janna',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _screenWidth * 0.16,
                      ),
                      CustomTextField(
                        hint: 'اسم المنتج',
                        fillColor: kThrColor,
                        onClicK: (value) {
                          _name = value;
                        },
                      ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      CustomTextFieldForMoney(
                        onClicK: (value) {
                          _price = value;
                        },
                        hint: 'سعر المنتج',
                        fillColor: kThrColor,
                      ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      CustomTextField(
                        onClicK: (value) {
                          _description = value;
                        },
                        hint: 'وصف المنتج',
                        fillColor: kThrColor,
                      ),
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DropdownButtonFormField(
                            // isExpanded: true,
                            value: _dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            decoration: InputDecoration(
                              labelText: "أختر الفئه",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            items: _categories.map((String value1) {
                              return new DropdownMenuItem<String>(
                                value: value1,
                                child: new Text(value1),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                _dropdownValue = newValue;
                              });
                            },
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return 'Please Select Pet';
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                      ),
                      // DropDown(_categories, dropdownValue),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Image(
                              image: AssetImage(
                                  'assets/images/icons/ic_addProduct.png'
                              ),
                              width: MediaQuery.of(context).size.width * .15,
                            ),
                            onTap: () {
                              getImage(context);
                            },
                          ),
                          Text(
                            'أختر صوره',
                            style: TextStyle(
                              fontFamily: 'Janna',
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      Image.file(
                        new File('$imagePhat'),
                        height: isThereAnImage == false
                            ? 0
                            : MediaQuery.of(context).size.height * .1,
                      ),
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        // تم
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Builder(
                            builder: (context) => MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                onPressed: () async {
                                  final _progress = ProgressHUD.of(
                                      context); // implement progress bar
                                  _progress.showWithText('جاري التحميل...');
                                  if (_globalKey.currentState.validate()) {
                                    _globalKey.currentState.save();
                                    try {
                                      _progress.show();
                                      print('جاري تحميل الصوره');
                                      await uploadProductPic(
                                          context); // بيتم تجميل الصوره الى الفايربيس
                                      print('جاري إضافة المنتج');
                                      _store.addProduct(ProductData(
                                          null,
                                          null,
                                          _name,
                                          _price,
                                          _description,
                                          _dropdownValue,
                                          _imageURL));
                                      _progress.dismiss();
                                      print('تم إضافة المنتج');

                                      // Scaffold.of(context).showBottomSheet(
                                      //     (context) => SnackBar(
                                      //         content: Text('تم الاضافة')));
                                    } catch (e) {
                                      _progress.dismiss();
                                      Scaffold.of(context).showBottomSheet(
                                          (context) => SnackBar(
                                              content: Text('خطأ في تحميل الصوره ')));
                                    }
                                  } else {
                                    _progress.dismiss();
                                  }
                                },
                                color: kMainColor,
                                child: Text(
                                  'إضافه',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: kMainColor,
                semanticsLabel: 'انتظر من فضلك',
              ));
            }
          }),
    );
  }

  Future getImage(context) async {
    // الحصول على صوره من المعرض
    // ignore: deprecated_member_use
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      // imageFromGal = image;
      imagePhat = image.path;
    });

    isThereAnImage = true;
    print('done');
  }

  Future uploadProductPic(BuildContext context) async {
    // رفع الصوره في قاعدة البيانات
    print('1');
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("ProductsPic/${basename(imagePhat)}");
    print('2');
    UploadTask uploadTask = firebaseStorageRef.putFile(File(imagePhat));
    print('1');
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => print('تم الاضافة الى قاعدة البيانات'));
// TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
//         Scaffold.of(context).showBottomSheet((context) => SnackBar(content: Text('تم الاضافة الى قاعدة البيانات'))));

    String urlFromFire = await taskSnapshot.ref.getDownloadURL();
    _imageURL = urlFromFire;
    print(_imageURL);
  }
}

// ignore: must_be_immutable
class DropDown extends StatefulWidget {
  final List<String> listOfCategory;

  DropDown({@required this.listOfCategory});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    String _dropdownValue;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField(
          // isExpanded: true,
          value: _dropdownValue,
          icon: Icon(Icons.arrow_downward),
          decoration: InputDecoration(
            labelText: "أختر الفئه",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          items: widget.listOfCategory.map((String value1) {
            return new DropdownMenuItem<String>(
              value: value1,
              child: new Text(value1),
            );
          }).toList(),
          onChanged: (String newValue) {
            setState(() {
              _dropdownValue = newValue;
              Provider.of<DropdownManage>(context).setDropdownValue(newValue);
            });
          },
        ),
      ),
    );
  }
}

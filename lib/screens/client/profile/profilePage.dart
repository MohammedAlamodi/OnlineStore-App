import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/controller/userController.dart';
import 'package:market_app/models/userModel.dart';
import 'package:market_app/services/locator.dart';

import 'getAvatarPhoto.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel _currentUser = locator.get<UserController>().currentUser;
  final _auth = FirebaseAuth.instance;
  // final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: statusBarHeight),
        Container(
          decoration: BoxDecoration(
              color: kMainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _screenHeight * .03,
              ),
              GetUserAvatar(
                avatarUrl: _currentUser.personalImageUrl,
                onTap: () async {
                  // final ImagePicker _picker = ImagePicker();
                  // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  final image = await ImagePicker().getImage(source: ImageSource.gallery);
                  if (image == null) return null;
                  setState(() {
                    locator.get<UserController>().uploadProfilePicture(File(image.path));
                  });
                },
              ),
              SizedBox(
                height: _screenHeight * .01,
              ),
              Text(
                ' اهلاً، ${_currentUser?.userInfo[0]?? "سعيدين بوجودك هنا"}',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Janna',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${_auth.currentUser.email}',
                style: TextStyle(color: Colors.white70, fontFamily: 'Janna'),
              ),
              // SizedBox(height: _screenHeight*.01,),
              SizedBox(height: _screenHeight * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: kSecondaryColor,
                          child: Image(
                            image: AssetImage(
                                'assets/images/icons/ic_profile_order.png'),
                            width: isPortrait
                                ? _screenHeight * .05
                                : _screenHeight * .06,
                          )),
                      Text(
                        'الطلبيات',
                        style:
                            TextStyle(fontFamily: 'Janna', color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: kSecondaryColor,
                          child: Image(
                            image: AssetImage(
                                'assets/images/icons/ic_profile_returnPurchase.png'),
                            width: isPortrait
                                ? _screenHeight * .04
                                : _screenHeight * .05,
                          )),
                      Text(
                        'الإرجاع',
                        style:
                            TextStyle(fontFamily: 'Janna', color: Colors.white),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundColor: kSecondaryColor,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/icons/ic_profile_wallet.png'),
                                width: isPortrait
                                    ? _screenHeight * .05
                                    : _screenHeight * .06,
                              ))),
                      Text(
                        'رصيدك',
                        style:
                            TextStyle(fontFamily: 'Janna', color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),

              SizedBox(height: _screenHeight * .02),

              // Text('اهلاً، ${currentUser?.uid ?? " سعيدين بوجودك معنا"}',style: TextStyle(color: Colors.white,fontFamily: 'Janna'),),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [

                  SizedBox(
                    width: _screenWidth * .05,
                  ),

                  Text(
                    'حسابي',
                    style: TextStyle(fontFamily: 'Janna', fontSize: 22),
                  ),
                  SizedBox(
                    height: _screenHeight * .04,
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                          Icon(Icons.favorite),
                          SizedBox(
                            width: _screenWidth * .03,
                          ),
                          Text(
                            'قائمتي المفضلة',
                            style: TextStyle(fontFamily: 'Janna'),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.navigate_next))),
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      Center(
                        child: Container(
                          color: Colors.black26,
                          height: _screenHeight * .0015,
                          width: _screenWidth * .9,
                        ),
                      ),
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                          Image(
                            image: AssetImage(
                                'assets/images/icons/ic_profile_wallet.png'),
                            width: isPortrait
                                ? _screenHeight * .035
                                : _screenWidth * .035,
                          ),
                          SizedBox(
                            width: _screenWidth * .03,
                          ),
                          Text(
                            'الدفع',
                            style: TextStyle(fontFamily: 'Janna'),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.navigate_next))),
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      Center(
                        child: Container(
                          color: Colors.black26,
                          height: _screenHeight * .0015,
                          width: _screenWidth * .9,
                        ),
                      ),
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                          Icon(Icons.person_pin),
                          SizedBox(
                            width: _screenWidth * .03,
                          ),
                          Text(
                            'الملف الشخصي',
                            style: TextStyle(fontFamily: 'Janna'),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.navigate_next))),
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _screenHeight * .02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: _screenWidth * .06,
                  ),
                  Text(
                    'الأعدادات',
                    style: TextStyle(fontFamily: 'Janna', fontSize: 22),
                  ),
                  SizedBox(
                    height: _screenHeight * .05,
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                          Icon(Icons.location_on_outlined),
                          SizedBox(
                            width: _screenWidth * .03,
                          ),
                          Text(
                            'الموقع',
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${_currentUser.userInfo[1] ?? "..."}',),
                              Icon(Icons.navigate_next),
                            ],
                          )),
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      Center(
                        child: Container(
                          color: Colors.black26,
                          height: _screenHeight * .0015,
                          width: _screenWidth * .9,
                        ),
                      ),


                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                          Icon(Icons.language_outlined),
                          SizedBox(
                            width: _screenWidth * .03,
                          ),
                          Text(
                            'اللغة',
                            style: TextStyle(fontFamily: 'Janna'),
                          ),
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('العربيه',
                                          style:
                                              TextStyle(fontFamily: 'Janna')),
                                      Icon(Icons.navigate_next),
                                    ],
                                  )),
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenHeight * .01,
                      ),
                      Center(
                        child: Container(
                          color: Colors.black26,
                          height: _screenHeight * .0015,
                          width: _screenWidth * .9,
                        ),
                      ),


                      SizedBox(
                        height: _screenHeight * .02,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                          Icon(Icons.notification_important_outlined),
                          SizedBox(
                            width: _screenWidth * .03,
                          ),
                          Text(
                            'إعدادات الإشعارات',
                            style: TextStyle(fontFamily: 'Janna'),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.navigate_next))),
                          SizedBox(
                            width: _screenWidth * .02,
                          ),
                        ],
                      ),
                      SizedBox(height: _screenHeight * .01,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: _screenHeight*.02,)
            ],
          ),
        )
      ],
    ));
  }
}



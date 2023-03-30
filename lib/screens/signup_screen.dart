// import 'package:flutter/material.dart';
// import 'package:market_app/constants.dart';
// import 'package:market_app/customWidgets/custom%20textField.dart';
// import 'package:market_app/customWidgets/custom%20AppLogo.dart';
// import 'package:market_app/services/auth.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:market_app/services/store.dart';
// import 'login_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/screens/login_screen.dart';
import 'package:market_app/services/auth.dart';
import 'package:market_app/services/store.dart';

import '../customWidgets/custom AppLogo.dart';
import '../customWidgets/custom textField.dart';

class SignUpScreen extends StatelessWidget {

  static String id = 'SignUpScreen';

  static GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password, _userName, _userGovernorate;
  final _auth = Auth();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Color textColor = Colors.white;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ProgressHUD(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: CustomAppLogo(
                  textColor: textColor,
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                onClicK: (value) {
                  _userName=value;
                },
                hint: 'اسمك',
                icon: Icons.person,
                fillColor: kSecondaryColor,

              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClicK: (value) {
                  _userGovernorate=value;
                },
                hint: 'المحافظه',
                icon: Icons.person,
                fillColor: kSecondaryColor,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClicK: (value) {
                  _email = value;
                },
                hint: 'الأيميل',
                icon: Icons.email,
                fillColor: kSecondaryColor,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClicK: (value) {
                  _password = value;
                },
                hint: 'كلمة المرور',
                icon: Icons.lock,
                fillColor: kSecondaryColor,
              ),
              SizedBox(
                height: height * .02,
              ),
              // CustomTextField(hint: 'Confirm Password', icon: Icons.lock),
              // SizedBox(
              //   height:height*.04 ,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) =>

                      MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        final _progress =
                            ProgressHUD.of(context); // implement progress bar

                        if (_globalKey.currentState.validate()) {
                          _progress.showWithText('يتم التحميل بياناتك...');
                          // _progress.show();
                          _globalKey.currentState.save();
                          try {
                            await _auth.signUp(_email, _password);
                            var _user = await _auth.getUser();
                            await _store.addUserInfo(
                                _user.uid, _userName, _userGovernorate);
                            _progress.dismiss();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LoginScreen.id,
                                (Route<dynamic> route) => false);
                          } catch (e) {
                            _progress.dismiss();
                            Scaffold.of(context).showBottomSheet((context) => SnackBar(content: Text(e.toString())));
                            // Scaffold.of(context).showSnackBar(SnackBar(
                            //   content: Text(e.message),
                            // )

                          }
                        }
                        _progress.dismiss();
                      },
                      color: Colors.white,
                      child: Text(
                        'التسجيل',
                        style: TextStyle(
                          color: kMainColor,
                          fontFamily: 'Janna',
                        ),                      )),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text('تسجيل الدخول',
                        style:
                            TextStyle(color: Color(0xFFC7EDE6), fontSize: 16,fontFamily: 'Janna',)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'لديك حساب؟',
                    style: TextStyle(color: Colors.white, fontSize: 16,),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

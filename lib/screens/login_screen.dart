import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:market_app/constants.dart';
import 'package:market_app/controller/userController.dart';
import 'package:market_app/customWidgets/custom%20AppLogo.dart';
import 'package:market_app/customWidgets/custom%20textField.dart';
import 'package:market_app/providers/adminMode.dart';
import 'package:market_app/screens/admin/adminHome.dart';
import 'package:market_app/screens/signup_screen.dart';
import 'package:market_app/services/auth.dart';
import 'package:market_app/services/locator.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import 'client/home/home_switch.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  static GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  final adminPassword = 'admin123';
  final adminPassword2 = 'a123456';

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
    Color textColor = Colors.white;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ProgressHUD(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: CustomAppLogo(textColor: textColor,),
              ),
              SizedBox(
                height: _screenHeight * .13,
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
                height: _screenHeight * .02,
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
                height: _screenHeight * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('تسجيل الدخول كـ ادمن',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Janna',
                  ),
                  ),
                  SizedBox(
                    width: _screenWidth * .03,
                  ),
                  RoundCheckBox(
                    onTap: (selected) {
                      if(selected){
                        Provider.of<AdminMode>(context, listen: false)
                            .changIsAdmin(true);
                      }else{
                        Provider.of<AdminMode>(context, listen: false)
                            .changIsAdmin(false);
                      }
                    },
                    uncheckedWidget: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(
                height: _screenHeight * .04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(  // هذي علشان تحصل على الcontext الي تحت السكافولد الرئيسي ,, لاجل نستخدمه للSnackBar
                  builder: (context) => MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        _validate(context);
                      },
                      color: Colors.white,
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(color: kMainColor,
                          fontFamily: 'Janna',),

                      )),
                ),
              ),
              SizedBox(
                height: _screenHeight * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text('التسجيل',
                        style:
                            TextStyle(color: Color(0xFFC7EDE6),
                              fontFamily: 'Janna',),),

                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '  ليس لديك حساب؟',
                    style: TextStyle(color: Colors.white, fontFamily: 'Janna',),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final _progress = ProgressHUD.of(context); // implement progress bar

    if (_globalKey.currentState.validate()) {
      _progress.showWithText('Loading...');
      _progress.show();
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context,listen: false).isAdmin) { //if he admin
        if (_password == adminPassword || _password == adminPassword2) {
          try {
            // await locator.get<UserController>().controlTheSignIn(_email, _password);
            await _auth.signIn(_email.trim(), _password.trim());
            _progress.dismiss();
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            _progress.dismiss();
            Scaffold.of(context).showBottomSheet((context) => SnackBar(content:Text(e.message)));

          }
        } else {
          _progress.dismiss();
          Scaffold.of(context).showBottomSheet((context) => SnackBar(content:Text('Something went wrong')));

        }
      } else {
        try {
          await locator.get<UserController>().controlTheSignIn(_email, _password);
         // await _auth.signIn(_email.trim(), _password.trim());
          _progress.dismiss();
          Navigator.pushNamed(context, HomeSwitch.id);
        } catch (e) {
          _progress.dismiss();
          print(e.message);
          Scaffold.of(context).showBottomSheet((context) => SnackBar(content:Text(e.message)));

        }
      }
    }
    _progress.dismiss();
  }
}

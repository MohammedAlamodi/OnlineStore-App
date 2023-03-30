import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClicK;
  final Color fillColor;

  String _errorMessage(String str){
    switch(hint){
      case 'اسمك' : return 'الاسم حقل مطلوب !';
      case 'الأيميل' : return 'الايميل حقل مطلوب !';
      case 'كلمة المرور' : return 'كلمة المرور حقل مطلوب !';
      default: return 'حقل مطلوب !';
    }
  }
  CustomTextField({ this.onClicK,  this.hint,  this.fillColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          validator: (value) {
            // ignore: missing_return
            if (value.isEmpty) {
              // ignore: missing_return
              return _errorMessage(hint);
              // ignore: missing_return, missing_return
            }
          },
          onSaved: onClicK,
          obscureText: hint == 'كلمة المرور' ?true: false ,
          cursorColor: kMainColor,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: kMainColor,
            ),
            filled: true,
            fillColor: fillColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}


class CustomTextFieldForMoney extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClicK;
  final Color fillColor;

  String _errorMessage(String str){
    switch(hint){
      case 'اسمك' : return 'الاسم حقل مطلوب !';
      case 'المحافظه' : return 'المحافظه حقل مطلوب !';
      case 'الأيميل' : return 'الايميل حقل مطلوب !';
      case 'كلمة المرور' : return 'كلمة المرور حقل مطلوب !';
      default: return 'حقل مطلوب !';
    }
  }
  CustomTextFieldForMoney({@required this.onClicK, @required this.hint, @required this.fillColor, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          inputFormatters: [CurrencyTextInputFormatter(
            locale: 'ko',
            decimalDigits: 0,)],
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return _errorMessage(hint);
              // ignore: missing_return
            }
          },
          onSaved: onClicK,
          obscureText: hint == 'كلمة المرور' ?true: false ,
          cursorColor: kMainColor,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: kMainColor,
            ),
            filled: true,
            fillColor: fillColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}



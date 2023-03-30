import 'package:flutter/material.dart';

import '../constants.dart';

class CustomRaisedButton extends StatelessWidget {
  final String name;
  final Function onPress;

  const CustomRaisedButton({
    @required this.name,
    @required this.onPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: MaterialButton(
        color: kMainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPress,
        child: Text(
          '$name',
            style: TextStyle(color: Colors.white,fontFamily: 'Janna',)
        ),
      ),
      // child: RaisedButton(
      //   color: kMainColor,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //   onPressed: onPress,
      //   child: Text(
      //     '$name',
      //     style: TextStyle(color: Colors.white,fontFamily: 'Janna',),
      //   ),
      // ),
    );
  }
}

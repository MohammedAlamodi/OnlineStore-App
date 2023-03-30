import 'package:flutter/material.dart';

class CustomAppLogo extends StatelessWidget {
  final Color textColor;
  const CustomAppLogo({
    @required this.textColor
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      child: Stack( //يخلي الويجت تجي فوق بعضها
        alignment: Alignment.center,
        children: [
          Image(image: AssetImage('assets/images/icons/loginScreen.png')),
          Positioned(
            bottom: 0,
            child: Text('متجر المكلا',
              style: TextStyle(
                fontFamily: 'Hala',
                color: textColor,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:market_app/mytest.dart';

class GetUserAvatar extends StatelessWidget {
  final String avatarUrl;
  final Function onTap;

  const GetUserAvatar({this.avatarUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: avatarUrl == null
            ? CircleAvatar(
                radius: 40,
                child: Icon(Icons.photo_camera_outlined),
              )
            : CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(avatarUrl),
              ),
      ),
    );
  }
}

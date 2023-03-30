import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:market_app/services/auth.dart';
import 'package:market_app/services/locator.dart';

class Storage {
  Storage();

  Auth _auth = locator.get<Auth>();

  Future<String> uploadProfilePic(File file) async {
    var user = await _auth.getUser();

    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("user/profile/${user.uid}");
    var uploadTask = firebaseStorageRef.putFile(file);
    var taskSnapshot = await uploadTask
        .whenComplete(() => print('تم الاضافة الى قاعدة البيانات'));
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImageDownloadUrl(String uid) async {
    var user = await _auth.getUser();
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child("user/profile/${user.uid}");
      String url = await storageRef.getDownloadURL();
      return url;
    } catch (ex) {
      return null;
    }
  }
}

import 'dart:io';
import 'package:market_app/models/userModel.dart';
import 'package:market_app/services/auth.dart';
import 'package:market_app/services/locator.dart';
import 'package:market_app/services/storage.dart';
import 'package:market_app/services/store.dart';

class UserController {
  UserModel _currentUser;
  Auth _auth = locator.get<Auth>();
  Store _store = Store();
  Storage _storage = locator.get<Storage>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _auth.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(File file) async {
    _currentUser.personalImageUrl =
        await locator.get<Storage>().uploadProfilePic(file);
  }

  //اذا سوى loin بيحمل الصوره حقه
  Future<String> getDownloadUrl() async {
    // print('1111');
    return await _storage.getUserProfileImageDownloadUrl(currentUser.uid);
  }

  Future<List<String>> getDownloadUserInfo() async {
    return await _store.loadUserInfo(currentUser.uid);
  }

  // ignore: missing_return
  Future<void> controlTheSignIn(String email, String password) async {
    _currentUser = await _auth.signIn(email.trim(), password.trim());

    _currentUser.personalImageUrl = await getDownloadUrl();
    _currentUser.userInfo = await getDownloadUserInfo();
    print('رابط الصوره : ${_currentUser.personalImageUrl}');
    print('UserID : ${_currentUser.uid}');
  }
}

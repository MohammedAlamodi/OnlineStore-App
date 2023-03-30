// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:market_app/models/userModel.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  Auth();

  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserModel> signIn(String email, String password) async {
    var authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel(
        authResult.user.uid,
    );
  }

  Future<UserModel> getUser() async {
    var user = await _auth.currentUser;
    return UserModel(user.uid);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

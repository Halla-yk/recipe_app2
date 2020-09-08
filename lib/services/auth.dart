
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{

  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  //signup method
  Future<UserCredential> signUp(String email,String password)async{
    // رح ترجعلي قيمة بالمستقبل من نوع AuthResult
    final  UserCredential user= await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }
  //signin method
  Future<UserCredential> signIn(String email,String password)async{
    // رح ترجعلي قيمة بالمستقبل من نوع AuthResult
    final UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }
  User getUser() {
    return  _auth.currentUser;
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
//    GoogleSignInAuthentication _googleSignInAuthentication =
//    await _googleSignInAccount.authentication;
//    AuthCredential _authCredential = GoogleAuthProvider.credential(
//        idToken: _googleSignInAuthentication.idToken,
//        accessToken: _googleSignInAuthentication.accessToken);
//    UserCredential _userCredential = await _auth.signInWithCredential(_authCredential);
//    User _user = _userCredential.user;
//    print(_user.email);
  }
  Future<void> signOut()async{
    await _auth.signOut();
  }
}
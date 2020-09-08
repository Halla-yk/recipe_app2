import 'package:flutter/cupertino.dart';
import 'package:recipe_app/constant.dart';

class User {
  String id;
  String fullName;

  // String password;
  String email;
  DateTime dateOfBirth;
  String imgUrl;

  User(
      {@required this.dateOfBirth,
      @required this.fullName,
      @required this.id,
      //  @required this.password,
      @required this.email,
      this.imgUrl});

  factory User.fromDB(Map<String, dynamic> db) {
    return User(
      id: db[KUserId],
      fullName: db[KUserName],
      email: db[KUserEmail],
      dateOfBirth: db[KUserDateOfBirth],
      imgUrl: db[KUserImgUrl]
    );
  }
}

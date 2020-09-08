import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/constant.dart';

class Store {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  addUser(
      {@required String id,
      @required String fullName,
      @required DateTime dateOfBirth,
      String imgUrl,
      @required String email}) {
    _fireStore.collection(KUserCollection).doc(id).set({
      KUserId: id,
      KUserName: fullName,
      KUserDateOfBirth: Timestamp.fromDate(dateOfBirth),
      KUserImgUrl: imgUrl,
      KUserEmail: email
    });
    print('done');
  }

  Future<User> getUser(String uId) async {
    User user;
    await _fireStore
        .collection(KUserCollection)
        .doc(uId)
        .get()
        .then((value) => user = User.fromDB(value.data()));
    return user;
  }

//  Future<Map<String,dynamic>> getUserById(String id) async{
//    return await _fireStore.doc(id).get().then((docSnapshot) =>  docSnapshot.data());
//  }
  Future<Map<String,dynamic>> getUserById(String id) async{
    return _fireStore.collection(KUserCollection).doc(id).get().then((value) => value.data());
  }
//  addUser(User user) {
//    _fireStore.collection(KUserCollection).add({
//      KUserId: user.id,
//      KUserName: user.fullName,
//      KUserDateOfBirth: Timestamp.fromDate(user.dateOfBirth),
//      KUserPassword: user.password,
//      KUserImgUrl: user.imgUrl,
//      KUserEmail: user.email
//    });
//    print('done');
//  }

//  addProduct(Product product) {
//    _fireStore.collection(KProductCollection).add({
//      KProductCategory: product.category,
//      KProductDescription: product.description,
//      KProductName: product.name,
//      KProductPrice: product.price,
//      KProductLocation: product.location
//    });
//  }

}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/constant.dart';
import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/services/store.dart';

class HomePage extends StatefulWidget {
  static const route = 'homePage';
  final String userId;
   
  HomePage({@required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  Store _store = Store();
  @override
  void initState() {

    super.initState();
     print(widget.userId);
    getName(widget.userId);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(username),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 50,
                            width: 50,
                            image: AssetImage('assets/images/cook.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(3, 3),
                          blurRadius: 50)
                    ],
                    color: Colors.white),
                width: double.infinity,
                child: Column(
                  children: [],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//  Widget get getName {
//    CollectionReference users = FirebaseFirestore.instance.collection('users');
//    return FutureBuilder<DocumentSnapshot>(
//      future: users.doc(widget.userId).get(),
//      builder:
//          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//        if (snapshot.hasError) {
//          return Text("Something went wrong");
//        }
//
//        if (snapshot.connectionState == ConnectionState.done) {
//          Map<String, dynamic> data = snapshot.data.data();
//          data.forEach((key, value) {
//            print(key+":"+value);
//
//          });
//          return Text("Welcome ${data['fullName']}",
//              style: TextStyle(
//                  fontSize: 25,
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold));
//        }
//
//        return Text("loading");
//      },
//    );
//  }
//Widget getName(String userId){
//  FutureBuilder<User>(
//    //عند كل تغير بال list رح ينعمل rebuild لل stream
//    future: _store.getUser(userId),
//    builder: (context, snapshot) {
//      if (snapshot.hasData) {
//
//        for (var doc in snapshot.data.documents) {
//          //loop on list of documents(rows)
//          //ال doc عبارة عن map بتحتوي ال data
//          var data = doc.data; //map
//
//          products.add(Product(
//              id: doc.documentID,
//              name: data[KProductName],
//              price: data[KProductPrice],
//              location: data[KProductLocation],
//              description: data[KProductDescription],
//              category: data[KProductCategory]));
//          //بدي ارجع list of products وبدي اعبي ال attributes تبعتها من ال doc data
//
//        }
//        _allProducts = [...products];
//        products.clear();
//        return gridViewForEachCategory(KJackets);
//      } else {
//        return Text("loading...");
//      }},
//  );
//}
//getName(String userId)async{
//    widget.user = await _store.getUser(userId);
//}
getName(String userId)async{
     Map<String,dynamic>  data= await _store.getUserById(userId);
     setState(() {
       username = data['fullName'];
     });
  print(data['fullName']);
}
}

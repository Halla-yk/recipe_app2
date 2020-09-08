import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  static const route = 'chatScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(child: Text('Hello world'));
        },
        itemCount: 8,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/LPSf88rBfSGywF8519GN/messages')
              .snapshots()
              .listen((data) {
            print(data);

          });

          //ال snapshot بترجعلي stream بحيث كل تغير بصير بحدثلي اياه
          //ال listen بتتنفذ لكل data
        },
      ),
    );
  }
}

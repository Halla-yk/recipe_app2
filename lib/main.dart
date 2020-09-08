import 'package:flutter/material.dart';
import 'package:recipe_app/screens/chat_screen.dart';
import 'package:recipe_app/screens/home_page.dart';
import 'package:recipe_app/screens/login_screen.dart';
import 'package:recipe_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
       initialRoute: ChatScreen.route,
       routes: {LoginScreen.route: (context)=> LoginScreen(),
         SignUpScreen.route: (context)=> SignUpScreen(),
         HomePage.route: (context) =>HomePage(),
         ChatScreen.route: (context) => ChatScreen()
       },
    );
  }
}

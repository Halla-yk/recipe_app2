import 'package:flutter/material.dart';
import 'package:recipe_app/screens/signup_screen.dart';
import '../widgets/custom_textfield.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';
import 'home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginScreen extends StatefulWidget {
  static const route = 'loginScreen';
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password, phoneNumber;
  final auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/cook.jpg',
                  ))),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Color.fromRGBO(255, 255, 255, 0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'welcome to',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                        Text(
                          'Recipe App',
                          style: TextStyle(color: Colors.white, fontSize: 38),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: widget._globalkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        CustomTextField(
                          onClick: (value) {
                            email = value;
                          },
                          hint: 'Email',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          onClick: (value) {
                            password = value;
                          },
                          hint: 'Password',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                _showCustomDialog();
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Builder(
                          builder:(context) {
                            return MaterialButton(
                              height: 55,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () async{

                                  //تعني عند الضغط على الsign up  اعملي validate والي بدورها بتعمل rebuild لل form مع ال error message

                                  if(widget._globalkey.currentState.validate()){
                                       widget._globalkey.currentState.save();
                                    try{
                                      final authResult = await auth.signIn(email, password);
                                      print(authResult.user
                                          .uid);
                                      print('mama');
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(userId: authResult.user
                                                  .uid,)));
                                    }catch(e){
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),));
                                    }


                                  }

                                },

                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.green, fontSize: 16),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login with',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                minWidth: 80,
                                height: 50,
                                color: Colors.blue[700],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {},
                                child: Container(
                                    width: 80,
                                    height: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/facebook.png'),
                                      fit: BoxFit.fitHeight,
                                    ))),
                            SizedBox(
                              width: 30,
                            ),
                            MaterialButton(
                                minWidth: 70,
                                height: 55,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {
//                                async{
//                                 await auth.signInWithGoogle();
                                },
                                child: Container(
                                    width: 80,
                                    height: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/google-logo.png'),
                                      fit: BoxFit.fitHeight,
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'or',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          height: 55,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _showCustomDialog() async {
    final _auth = FirebaseAuth.instance;
    String email = '';
    AlertDialog alertDialog = AlertDialog(
      actions: [
        MaterialButton(
          child: Text('Send'),
          onPressed: () {
            _auth.sendPasswordResetEmail(email: email);
            Navigator.pop(context);
            print(email+'k');
          },
        )
      ],
      title: Text('Please enter your email to mail you a link.'),
      content: TextField(
        onChanged: (value) {
          email = value;
        },
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );

    await showDialog(context: (context), builder: (context) => alertDialog);
  }
}

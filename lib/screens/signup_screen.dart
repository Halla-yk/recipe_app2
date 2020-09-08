import 'package:flutter/material.dart';
import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/services/auth.dart';
import 'package:recipe_app/services/store.dart';
import 'package:recipe_app/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';
import 'home_page.dart';

class SignUpScreen extends StatefulWidget {
  static const route = 'signUpScreen';
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email, password, fullName, dateOfBirth, retypePassword;
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final auth = Auth();
  final store = Store();

  @override
  void dispose() {
    //بتتنفذ لما اطلع من ال page
    _passController.dispose();
    _confirmPassController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

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
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 38),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: widget._globalkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        CustomTextField(
                          validate: (value) {
                            if (value == '') {
                              return 'Full name is empty';
                            }
                            return null;
                          },
                          onClick: (value) {
                            fullName = value;
                          },
                          hint: 'Full name',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validate: (value) {
                            if (value == '') {
                              return 'email is empty';
                            }
                            return null;
                          },
                          onClick: (value) {
                            email = value;
                          },
                          hint: 'Email',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _dateOfBirthController,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _selectDate(context, _dateOfBirthController);
                          },
                          validate: (value) {
                            if (value == '') {
                              return 'Date of birth is empty';
                            }
                            return null;
                          },
                          onClick: (value) {
                            dateOfBirth = value;
                          },
                          hint: 'Date of birth',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _passController,
                          validate: (value) {
                            if (value == '') {
                              return 'Password is empty';
                            }
                            return null;
                          },
                          onClick: (value) {
                            password = value;
                            print(_passController.text);
                          },
                          hint: 'Password',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _confirmPassController,
                          validate: (value) {
                            if (value == '') {
                              return 'Password is empty';
                            }
                            if (value != _passController.text)
                              return 'Not Match';
                            return null;
                          },
                          onClick: (value) {
                            retypePassword = value;
                            print(retypePassword);
                          },
                          hint: 'Retype password',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Builder(
                          builder: (context) {
                            return MaterialButton(
                              height: MediaQuery.of(context).size.height * 0.08,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () async {
                                print(_dateOfBirthController.value);
                                print('hello');
                                if (widget._globalkey.currentState.validate()) {
                                  widget._globalkey.currentState.save();
                                  try {
                                    final authResult = await auth.signUp(
                                        email.trim(), password.trim());
                                    print(authResult.user
                                        .uid); //هادا ال id ال firebase هو اللي بعملي اياه

                                    store.addUser(id: authResult.user
                                        .uid,fullName: fullName,dateOfBirth: selectedDate,email: email);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(userId: authResult.user
                                                .uid,)));
                                  } catch (e) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(e
                                          .message), //ممكن الاكسبشن علشان الايميل متكرر او علشان الفورمات غلط تبع الايميل
                                    ));
                                  }
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Register with',
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
                                minWidth:
                                    MediaQuery.of(context).size.height * 0.08,
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
                                minWidth:
                                    MediaQuery.of(context).size.height * 0.08,
                                height: 55,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {},
                                child: Container(
                                    width: 80,
                                    height: 40,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/google-logo.png'),
                                      fit: BoxFit.fitHeight,
                                    )))
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
                          height: MediaQuery.of(context).size.height * 0.07,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {},
                          child: Text(
                            'Login',
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

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController dateOBirthController) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.amberAccent,
                surface: Colors.green,
              ),
            ),
            child: child,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2021));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateOBirthController.value =
            TextEditingValue(text: DateFormat.yMd().format(selectedDate));
//        dateOBirthController.text = DateFormat.yMd().format(selectedDate);
//        print(dateOBirthController.text);
      });
  }
}

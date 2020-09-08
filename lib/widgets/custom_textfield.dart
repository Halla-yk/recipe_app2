import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Function onClick;
  final Function validate;
  final Function onTap;
  CustomTextField(
      {@required this.onClick,
      @required this.hint,
      this.controller,
        this.onTap,
      @required this.validate});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        onSaved: onClick,
        validator: validate,
        obscureText: hint == 'Password' || hint == 'Retype password' ? true : false,
        //علشان يعمل الباسورد نجوم
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
        decoration: InputDecoration(

            hintStyle: TextStyle(color: Colors.white, fontSize: 16),
            hintText: this.hint,
            filled: true,
            fillColor: Color.fromRGBO(255, 255, 255, 0.55),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.red))),
      ),
    );
  }
}

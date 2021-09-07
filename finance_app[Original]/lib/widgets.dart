import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTextField(String text, String prefix, TextEditingController control,
    Function changeCurrency) {
  return TextFormField(
    controller: control,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: text,
        labelStyle:
            TextStyle(color: Color.fromRGBO(222, 164, 80, 20), fontSize: 30.0),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amberAccent, fontSize: 25.0),
    onChanged: changeCurrency,
  );
}

Widget buildTextCharger(String text) {
  return Text(text,
      style: TextStyle(color: Colors.black, fontSize: 25.0),
      textAlign: TextAlign.center);
}

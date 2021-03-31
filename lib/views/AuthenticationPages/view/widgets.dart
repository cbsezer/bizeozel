import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartal/kartal.dart';

Widget inputBoxAuth(TextEditingController controller, BuildContext context,
    String string, TextInputType textInputType, validator, suffixIcon) {
  return Container(
    height: 50,
    width: context.width * 0.75,
    child: Center(
      child: TextFormField(
        obscureText:
            (string == 'Password' || string == 'Password Again') ? true : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return validator();
        },
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: string,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: Icon(suffixIcon, color: Colors.grey),
        ),
      ),
    ),
  );
}

Widget registerButton(BuildContext context, key, returnFunction, text, imgUrl) {
  return InkWell(
    onTap: () {
      if (key.currentState.validate() && imgUrl != null) {
        return returnFunction();
      } else {
        Fluttertoast.showToast(msg: 'img null');
      }
    },
    child: Container(
      alignment: Alignment.center,
      width: context.width < 540 ? 100 : 120,
      height: context.height < 540 ? 42 : 42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            Color(0xff656ae9),
            Color(0xfffdd0d0),
          ])),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      ),
    ),
  );
}

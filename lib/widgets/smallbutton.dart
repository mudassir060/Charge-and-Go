
import 'package:flutter/material.dart';

import '../constants/style.dart';

Widget smallbutton(String name, Null Function() function){
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(appBarColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
    onPressed: function,
    child: Center(
        child:  Text(
          name,
          style: TextStyle( fontWeight: FontWeight.bold),
        )),
  );
}
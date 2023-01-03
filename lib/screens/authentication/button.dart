// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../../widgets/loadingwidget.dart';

Widget large_button(
    {required double width,
    required Null Function() function,
    required String name, required bool loading}) {
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
    child: SizedBox(
      width: width - 100,
      height: 50,
      child: Center(
          child: loading?loadingwidget(color: Colors.white,): Text(
        name,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    ),
  );
}

import 'package:flutter/material.dart';

Widget gridbuttton(String s,  Function() param1) {
  return InkWell(
    onTap: () {
      param1();
    },
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey[200],
        ),
        child: Center(
            child: Text(
          s,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ))),
  );
}

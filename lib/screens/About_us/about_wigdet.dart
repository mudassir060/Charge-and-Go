import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../widgets/spacer.dart';

Widget heading(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: seconderyColor),
    ),
  );
}

Widget paragraph(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
    ),
    textAlign: TextAlign.start,
  );
}

Widget rowpara(
  String heading,
  String text,
) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold, color: seconderyColor),
        ),
        spacer(12.0, 0.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );
}

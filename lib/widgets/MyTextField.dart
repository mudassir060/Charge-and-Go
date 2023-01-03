import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.hintText,
    required this.width,
    required this.controller, required this.icon, this.keyboardType,
  }) : super(key: key);
  String hintText;
  var width;
  TextInputType? keyboardType;
  IconData icon;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FaIcon(icon,color: Colors.grey,),
        ),
        SizedBox(
          width: width,
          child: TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: UnderlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

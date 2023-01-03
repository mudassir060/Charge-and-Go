import 'package:flutter/material.dart';

import '../../../../constants/style.dart';

class DetailField extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;
  final bool isYellow;

  const DetailField(
      {required this.title,
      required this.text,
      required this.icon,
      this.isYellow = false});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: isYellow == true ? seconderyColor : appBarColor),
            const SizedBox(width: 10),
            Text("$title :",
                style: TextStyle(
                    fontSize: 18,
                    color: isYellow == true ? seconderyColor : appBarColor)),
          ]),
          const SizedBox(width: 10),
          Text(text.toString(),
              style: const TextStyle(color: grey, fontSize: 18))
        ],
      ),
    );
  }
}

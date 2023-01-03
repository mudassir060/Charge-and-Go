import 'package:flutter/material.dart';

import '../../../../../constants/style.dart';

class HeaderContainer extends StatelessWidget {
  final String title;
  final Function() onTap;
  final int value;
  final bool isAdSold;

  const HeaderContainer(
      {required this.title, 
      required this.onTap,
      required this.value, this.isAdSold = false});

  final style = const TextStyle(
      fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: width * 0.50,
        color: isAdSold == true ? appBarColor : seconderyColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isAdSold != true) const SizedBox(width: 40),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(title, style: style),
              const SizedBox(height: 10),
              // Text("$value", style: style)
              Text("", style: style)
            ]),
            if (isAdSold == true) const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}

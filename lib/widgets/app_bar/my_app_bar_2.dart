import 'package:flutter/material.dart';

import '../../constants/style.dart';

AppBar MyAppBar2(BuildContext context, String? title, bool? isBackButton,
    Null Function() function, bool isAddButton) {
  return AppBar(
    elevation: 0,
    backgroundColor: appBarColor,
    title: Text(
      title ?? "",
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: isBackButton == true
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(Icons.arrow_back, color: Colors.white)),
            ),
          )
        : null,
    actions: [
      isAddButton == true
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: function,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(Icons.add, color: Colors.white)),
              ),
            )
          : Container(),
    ],
  );
}

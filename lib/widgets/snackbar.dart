import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style.dart';


void snackbar( notification) {
  Get.snackbar(notification, "",
    // icon: Icon(_icon, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: seconderyColor,
    // borderRadius: 50,
    // padding:EdgeInsets.all(8),
    // margin: EdgeInsets.all(15),
    colorText: Colors.white,
    // duration: const Duration(seconds: 4),
    // isDismissible: true,
    // dismissDirection: DismissDirection.vertical,
    // forwardAnimationCurve: Curves.easeOutBack,
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Home/HomeScreen.dart';

upload_data(context, UserData, AdminData) async {
  final DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection("users")
      .doc("${UserData["UID"]}")
      .get();
  final data = snapshot.data();

  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                UserData: data as Map,
                AdminData: AdminData,
              )),
      (Route<dynamic> route) => false);
}

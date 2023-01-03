import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../widgets/snackbar.dart';
import 'upload_data.dart';

updata_data(context, UserData,AdminData, _title, value) async {
  print('=============>$UserData,======$_title, $value');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  await firestore.collection("users").doc("${UserData["UID"]}").update({
    _title: value,
  });
  snackbar('$_title  Sucessfuly');
  upload_data(context, UserData, AdminData);

}

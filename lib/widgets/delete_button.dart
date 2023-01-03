import 'package:charge_go/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/style.dart';

Widget delete_button(
  coll,
  UID,
) {
  return IconButton(
      onPressed: () async {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore
            .collection(coll)
            .doc(UID)
            .delete()
            .then((value) => snackbar("Delete successfully"))
            .catchError((onError) => snackbar(
                onError.toString()));
      },
      icon: Icon(
        Icons.more_vert,
        // color: Colors.red,
        // size: 38,
      ));
}

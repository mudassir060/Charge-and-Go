import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'upload_data.dart';

upload_pic(context, UserData, AdminData,) async {
  final XFile? _image =
  await ImagePicker().pickImage(source: ImageSource.gallery);
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child("Profiles/${DateTime.now().toString()}");
  UploadTask uploadTask = ref.putFile(File(_image!.path));
  uploadTask.whenComplete(() async {
    var url = await ref.getDownloadURL();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("users").doc("${UserData["UID"]}").update({
      "UserProfile": url,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Image is uploaded')));
    upload_data(context, UserData,AdminData);
  }).catchError((onError) {
    print("=====Error====>${onError}");
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Image Uploading Faild')));
  });
  // return url;
}
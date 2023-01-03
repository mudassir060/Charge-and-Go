import 'package:charge_go/screens/Home/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'screens/authentication/login_screen.dart';
import 'widgets/Expire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  Object? UserData = {};
  Object? AdminData = {};
  String UID = "null";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  FlutterSecureStorage storage = const FlutterSecureStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentSnapshot snapshot =
      await firestore.collection("Admin").doc("data").get();
  AdminData = snapshot.data();

  var Uid = await storage.read(key: "UID");
  if (Uid != null) {
    UID = Uid;
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(UID).get();
    final _data = snapshot.data();
    UserData = _data;
  }

  runApp(MyApp(AdminData as Map, UserData as Map, UID!));
}

class MyApp extends StatelessWidget {
  final Map AdminData;
  final Map UserData;
  final String UID;

  MyApp(
    this.AdminData,
    this.UserData,
    this.UID,
  );

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uet Services',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        // home: OnBoardingScreen(UserData: {}, AdminData: {},),
        // home: upload_data(),
        home: AdminData["Version"][0]
            ? UID != "null"
                ? HomeScreen(
                    UserData: UserData,
                    AdminData: AdminData,
                  )
                : login_screen(
                    admindata: AdminData,
                  )
            : Expire(url: "${AdminData["apkUrl"]}"));
  }
}

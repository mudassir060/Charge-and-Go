import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';
import '../../widgets/app_bar/my_app_bar_2.dart';
import '../../widgets/loadingwidget.dart';
import '../../widgets/snackbar.dart';
import '../Navigation/MyDrawer.dart';
import '../authentication/button.dart';
import '../authentication/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final Map UserData;
  final Map AdminData;

  const HomeScreen({Key? key, required this.UserData, required this.AdminData})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var barcode;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var showwidget = 0;

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((qrData) {
      setState(() async {
        barcode = qrData;
        if (barcode?.format == BarcodeFormat.qrcode) {
          try {
            setState(() {
              showwidget = 2;
            });
            DateTime now = DateTime.now();
            String formattedDate = DateFormat('dd MM yyyy HH:mm').format(now);
            print("===========>${barcode?.code}");
            await firestore.collection("BookRide").doc(barcode?.code).set({
              "barcode": barcode?.code,
              "UID": widget.UserData['UID'],
              "username": widget.UserData["username"],
              "email": widget.UserData["email"],
              "rollNo": widget.UserData["rollNo"],
              "PhoneNo": widget.UserData["PhoneNo"],
              "BookRideTime": formattedDate,
            });
            setState(() {
              showwidget = 3;
            });
          } on FormatException {
            snackbar("Invalid QR Code!");
          } on Exception {
            snackbar("Error!");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            drawer: MyDrawer(
              UserData: widget.UserData,
              AdminData: widget.AdminData,
            ),
            appBar: MyAppBar2(context, "Charge Go", false, () => null, false),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                showwidget == 0
                    ? large_button(
                        width: 250,
                        name: "Book a ride",
                        function: () {
                          setState(() {
                            showwidget = 1;
                          });
                        },
                        loading: false)
                    : showwidget == 1
                        ? Container(
                            height: 300,
                            width: 300,
                            child: QRView(
                              key: qrKey,
                              onQRViewCreated: onQRViewCreated,
                            ),
                          )
                        : showwidget == 2
                            ? const loadingwidget(
                                color: Colors.black,
                              )
                            : large_button(
                                width: 250,
                                name: "Stop ride",
                                function: () {
                                  setState(() {
                                    showwidget = 0;
                                  });
                                },
                                loading: false,
                              )
              ],
            )));
  }
}

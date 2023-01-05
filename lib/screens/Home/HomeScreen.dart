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
  bool showError = false;
  var RideData;

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((qrData) {
      setState(() async {
        barcode = qrData;
        if (barcode?.format == BarcodeFormat.qrcode) {
          try {
            setState(() {
              showwidget = 2;
            });
            final DocumentSnapshot snapshot =
                await firestore.collection("BookRide").doc(barcode?.code).get();
            final data = snapshot.data();
            setState(() {
              RideData = data;
            });
            if (RideData["UID"] == null) {
              DateTime now = DateTime.now();
              String formattedDate = DateFormat('dd MM yyyy HH:mm').format(now);
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
                showwidget = 0;
              });
            } else {
              setState(() {
                showError = true;
              });
            }
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
    final Stream<QuerySnapshot> _chargeGoStream = FirebaseFirestore.instance
        .collection('BookRide')
        // .orderBy('Date', descending: true)
        .where('UID', isEqualTo: widget.UserData["UID"])
        // .limitToLast(1)
        .snapshots();
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          drawer: MyDrawer(
            UserData: widget.UserData,
            AdminData: widget.AdminData,
          ),
          appBar: MyAppBar2(context, "Charge Go", false, () => null, false),
          body: StreamBuilder<QuerySnapshot>(
            stream: _chargeGoStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container(
                    child: Column(
                  children: [
                    Text('Something went wrong'),
                  ],
                ));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: loadingwidget(
                    color: Colors.black,
                  ),
                );
              }
              if (snapshot.data?.size == 0) {
                return Column(
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
                            ? Column(
                                children: [
                                  showError
                                      ? const Text(
                                          "This bike is already books try again bike")
                                      : Container(),
                                  Container(
                                    height: 300,
                                    width: 300,
                                    child: QRView(
                                      key: qrKey,
                                      onQRViewCreated: onQRViewCreated,
                                    ),
                                  ),
                                ],
                              )
                            : const loadingwidget(
                                color: Colors.black,
                              )
                  ],
                );
              }
              return GridView.extent(
                primary: false,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: (1 / 1.3),
                shrinkWrap: true,
                maxCrossAxisExtent: 300.0,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      large_button(
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
                  );
                }).toList(),
              );
            },
          )
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     showwidget == 0
          //         ? large_button(
          //             width: 250,
          //             name: "Book a ride",
          //             function: () {
          //               setState(() {
          //                 showwidget = 1;
          //               });
          //             },
          //             loading: false)
          //         : showwidget == 1
          //             ? Container(
          //                 height: 300,
          //                 width: 300,
          //                 child: QRView(
          //                   key: qrKey,
          //                   onQRViewCreated: onQRViewCreated,
          //                 ),
          //               )
          //             : showwidget == 2
          //                 ? const loadingwidget(
          //                     color: Colors.black,
          //                   )
          //                 : large_button(
          //                     width: 250,
          //                     name: "Stop ride",
          //                     function: () {
          //                       setState(() {
          //                         showwidget = 0;
          //                       });
          //                     },
          //                     loading: false,
          //                   )
          //   ],
          // ),
          ),
    );
  }
}

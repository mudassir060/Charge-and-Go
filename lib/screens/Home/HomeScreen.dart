import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:intl/intl.dart';
import '../../widgets/app_bar/my_app_bar_2.dart';
import '../../widgets/loadingwidget.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/spacer.dart';
import '../Navigation/MyDrawer.dart';
import '../authentication/button.dart';

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
  var _stoRide = 0;

  bool showError = true;
  var RideData;

  void rideBook(QRViewController controller) {
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
              snackbar("Ride booked successfully");
            } else {
              setState(() {
                showError = false;
              });
              snackbar("This bike is already books try again bike");
            }
            setState(() {
              showwidget = 0;
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

  void rideStop(QRViewController controller) {
    controller.scannedDataStream.listen((qrData) {
      setState(() async {
        barcode = qrData;
        if (barcode?.format == BarcodeFormat.qrcode) {
          try {
            final DocumentSnapshot snapshot =
                await firestore.collection("BookRide").doc(barcode?.code).get();
            final data = snapshot.data();
            setState(() {
              RideData = data;
            });
            if (RideData["UID"] != null && _stoRide ==barcode?.code) {
              DateTime now = DateTime.now();
              String formattedDate = DateFormat('dd MM yyyy HH:mm').format(now);
              await firestore.collection("BookRide").doc(barcode?.code).set({
                "barcode": barcode?.code,
                "UID": '',
                "username": '',
                "email": '',
                "rollNo": '',
                "PhoneNo": '',
                "BookRideTime": formattedDate,
              });
              snackbar("Ride Cancel");
            } else {
              snackbar("Not Allow to cancel Ride");
            }
            setState(() {
              showwidget = 0;
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
                    children: const [
                      Text('Something went wrong'),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: loadingwidget(
                    color: Colors.black,
                  ),
                );
              }
              if (snapshot.data?.size == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      showwidget == 0
                          ? Column(
                              children: [
                                Text(
                                    "Hi! Welcome ${widget.UserData["username"]}"),
                                large_button(
                                    width: 250,
                                    name: "Book a ride",
                                    function: () {
                                      setState(() {
                                        showwidget = 1;
                                      });
                                    },
                                    loading: false),
                              ],
                            )
                          : showwidget == 1
                              ? Column(
                                  children: [
                                    Container(
                                      height: 300,
                                      width: 300,
                                      child: QRView(
                                        key: qrKey,
                                        onQRViewCreated: rideBook,
                                      ),
                                    ),
                                  ],
                                )
                              : const loadingwidget(
                                  color: Colors.black,
                                )
                    ],
                  ),
                );
              }
              return Center(
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: ScrollController(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return _stoRide == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              spacer(100.0, 0.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  large_button(
                                      width: 200,
                                      name: "Stop ride",
                                      function: () {
                                        setState(() {
                                          _stoRide = int.parse(data["barcode"]);
                                        });
                                      },
                                      loading: false),
                                  large_button(
                                    width: 200,
                                    name: "Parked",
                                    function: () {},
                                    loading: false,
                                  ),
                                ],
                              ),
                              spacer(10.0, 0.0),
                              Text('Bick id: ${data["barcode"]}'),
                              spacer(10.0, 0.0),
                              Text('Booking Time: ${data["BookRideTime"]}')
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                height: 300,
                                width: 300,
                                child: QRView(
                                  key: qrKey,
                                  onQRViewCreated: rideStop,
                                ),
                              ),
                            ],
                          );
                  }).toList(),
                ),
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

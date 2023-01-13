import 'package:charge_go/screens/Home/widgets/history.dart';
import 'package:charge_go/screens/Home/widgets/userDetaileCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  var RideData;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void rideBook(QRViewController controller) {
    controller.scannedDataStream.listen((qrData) {
      setState(() async {
        barcode = qrData;
        if (barcode?.format == BarcodeFormat.qrcode) {
          await controller.pauseCamera();
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
            DateTime now = DateTime.now();
            String formattedDate = DateFormat('dd MM yyyy HH:mm').format(now);

            _getCurrentLocation().then((value) async => {
                  if (RideData["UID"] == null)
                    {
                      await firestore
                          .collection("BookRide")
                          .doc(barcode?.code)
                          .set({
                        "startLatitude": value.latitude,
                        "startLongitude": value.longitude,
                        "barcode": barcode?.code,
                        "UID": widget.UserData['UID'],
                        "username": widget.UserData["username"],
                        "condition": 1,
                        "email": widget.UserData["email"],
                        "rollNo": widget.UserData["rollNo"],
                        "PhoneNo": widget.UserData["PhoneNo"],
                        "BookRideTime": formattedDate,
                      }),
                      snackbar("Ride booked successfully"),
                    }
                  else
                    {
                      snackbar(
                          "This bike is already ${RideData["condition"] == 2 ? "Parked" : "books"} by ${RideData["username"]}")
                    }
                });
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

  Future<void> stopRide(data) async {
    if (data["UID"] != null) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd MM yyyy HH:mm').format(now);
      await firestore.collection("BookRide").doc("${data["barcode"]}").set({
        "barcode": data["barcode"],
      });
      await firestore.collection("users").doc(widget.UserData["UID"]).update({
        "BookRideTime": data["BookRideTime"],
        "StopRideTime": formattedDate,
      });
      await firestore.collection("History").doc().set({
        "barcode": data['barcode'],
        "UID": data['UID'],
        "username": data["username"],
        "email": data["email"],
        "rollNo": data["rollNo"],
        "PhoneNo": data["PhoneNo"],
        "BookRideTime": data["BookRideTime"],
        "StopRideTime": formattedDate,
      });
      snackbar("Ride Cancel");
    } else {
      snackbar("Not Allow to cancel Ride");
    }
    setState(() {
      showwidget = 0;
    });
  }

  Future<void> parkedRide(data) async {
    if (data["UID"] != null) {
      // DateTime now = DateTime.now();
      await firestore.collection("BookRide").doc("${data["barcode"]}").update({
        "condition": 2,
      });
      _getCurrentLocation().then((value) async => {
            await firestore
                .collection("users")
                .doc(widget.UserData["UID"])
                .update({
              "startLatitude": data["startLatitude"],
              "startLongitude": data["startLongitude"],
              "endLatitude": value.latitude,
              "endLongitude": value.longitude,
            })
          });
      snackbar("Ride Parked");
    } else {
      snackbar("Not Allow to Parked Ride");
    }
    setState(() {
      showwidget = 0;
    });
  }

  Future<void> unparkedRide(data) async {
    if (data["UID"] != null) {
      // DateTime now = DateTime.now();
      await firestore.collection("BookRide").doc("${data["barcode"]}").update({
        "condition": 1,
      });
      snackbar("Ride UnParked");
    } else {
      snackbar("Not Allow to UnParked Ride");
    }
    setState(() {
      showwidget = 0;
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showwidget == 0
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height - 85,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                userDetaileCard(UserData: widget.UserData),
                                large_button(
                                    width: 250,
                                    name: "Book a ride",
                                    function: () {
                                      setState(() {
                                        showwidget = 1;
                                      });
                                    },
                                    loading: false),
                                Row(
                                  children: const [
                                    Text(
                                      "    History",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: 400,
                                    child: history(
                                      UserData: widget.UserData,
                                    ))
                              ],
                            ),
                          )
                        : showwidget == 1
                            ? Center(
                                child: Column(
                                  children: [
                                    spacer(100.0, 0.0),
                                    Container(
                                      height: 300,
                                      width: 300,
                                      child: QRView(
                                        key: qrKey,
                                        onQRViewCreated: rideBook,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const loadingwidget(
                                color: Colors.black,
                              )
                  ],
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
                                        stopRide(data);
                                      },
                                      loading: false),
                                  data["condition"] != 2
                                      ? large_button(
                                          width: 200,
                                          name: "Parked",
                                          function: () {
                                            parkedRide(data);
                                          },
                                          loading: false,
                                        )
                                      : large_button(
                                          width: 200,
                                          name: "Unparked",
                                          function: () {
                                            unparkedRide(data);
                                          },
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
                        : Center();
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

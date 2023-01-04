import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widgets/app_bar/my_app_bar_2.dart';
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
  Barcode? result;
  QRViewController? controller;
  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((qrData) {
      setState(() {
        barcode = qrData;
        if (barcode?.format == BarcodeFormat.qrcode) {
          try {
            print("===========>${barcode?.code }");
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             ItemDisplay(key: const Key("item"), item: item)));
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
            appBar: MyAppBar2(context, "Setting", false, () => null, false),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                ),
                large_button(
                    width: 250,
                    name: "Login Now",
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_screen(
                                    admindata: {},
                                  )));
                    },
                    loading: false),
                Container(
                  height: 300,
                  width: 300,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCreated,
                  ),
                ),
              ],
            )));
  }
}

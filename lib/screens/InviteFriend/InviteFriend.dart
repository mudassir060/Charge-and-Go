import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/images.dart';
import '../../constants/style.dart';
import '../../widgets/app_bar/my_app_bar_2.dart';
import '../Navigation/MyDrawer.dart';
import '../authentication/button.dart';

class InviteFriend extends StatefulWidget {
  final Map UserData;
  final Map AdminData;

  const InviteFriend(
      {Key? key, required this.UserData, required this.AdminData})
      : super(key: key);

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    InviteNow() {
      Share.share("""Charge and go is an electric bike convenient, and sustainable to move through the 
university. all it takes is to download its android application scan the QR code on it 
to activate it and start your ride. You can drive everywhere within the coverage 
area. you can easily park the Bike at a suitable location and end your trip using the 
app. charge and go is an efficient, fun way to travel around. 👉👉${widget.AdminData["apkUrl"]}.""");

  }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: MyDrawer(
          UserData: widget.UserData,
          AdminData: widget.AdminData,
        ),
        appBar: MyAppBar2(context, "Invite Friend", false, () {}, false),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text(
                    "Share With Friends",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: seconderyColor),
                  ),
                ),
                Container(
                  height: 350,
                  width: 400,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(invitiation),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                ),
                large_button(
                    width: MediaQuery.of(context).size.width,
                    function: () {
                      InviteNow();
                    },
                    name: 'Invite Now',
                    loading: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

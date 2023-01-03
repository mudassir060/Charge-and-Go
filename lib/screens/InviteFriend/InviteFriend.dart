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
      Share.share("""Food waste management system for restaurants and food businesses. 
-Provides customers with real-time food waste management information.
-Provides restaurants and food businesses with a method to effectively manage food waste in their stores.
-Includes a mobile app that allows users to track food waste, manage donations and communicate with nonprofits.
 👉👉${widget.AdminData["apkUrl"]}.""");

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

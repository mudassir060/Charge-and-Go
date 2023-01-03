import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/icons.dart';
import '../../constants/style.dart';
import '../../widgets/snackbar.dart';
import '../Home/HomeScreen.dart';
import '../authentication/login_screen.dart';
import '../setting/settings_screen.dart';
import '../About_us/about_us.dart';
import '../InviteFriend/InviteFriend.dart';
import 'dart:io' show Platform;

class MyDrawer extends StatefulWidget {
  final Map UserData;
  final Map AdminData;

  const MyDrawer({Key? key, required this.UserData, required this.AdminData})
      : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

const int maxFailedLoadAttempts = 3;

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: appBarColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Icon(Icons.arrow_back,
                              color: Colors.white)),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 42,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: widget.UserData["UserProfile"] != null
                          ? DecorationImage(
                              image: NetworkImage(
                                  "${widget.UserData["UserProfile"]}"),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: AssetImage(sellerIcon), fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.UserData['username']}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            UserData: widget.UserData,
                            AdminData: widget.AdminData,
                          )),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: const Text(
              'Invite Friends',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.share),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => InviteFriend(
                            UserData: widget.UserData,
                            AdminData: widget.AdminData,
                          )),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: const Text(
              'Setting',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => settings_screen(
                            UserData: widget.UserData,
                            AdminData: widget.AdminData,
                          )),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: const Text(
              'About us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => about_us(
                            UserData: widget.UserData,
                            AdminData: widget.AdminData,
                          )),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              FlutterSecureStorage storage = const FlutterSecureStorage();
              await storage.delete(key: "UID");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          login_screen(admindata: widget.AdminData)));
              snackbar("Log Out Sccessfully");
            },
          ),
        ],
      ),
    );
  }
}

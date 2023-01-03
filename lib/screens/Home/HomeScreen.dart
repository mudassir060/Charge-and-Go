import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar/my_app_bar_2.dart';
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
                SizedBox(width: width,),
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
              ],
            )));
  }
}

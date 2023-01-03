import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar/my_app_bar_2.dart';
import '../Navigation/MyDrawer.dart';

class HomeScreen extends StatefulWidget {
  final Map UserData;
  final Map AdminData;
  const HomeScreen({Key? key, required this.UserData, required this.AdminData}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            drawer: MyDrawer(
              UserData: widget.UserData,
              AdminData: widget.AdminData,
            ),
            appBar: MyAppBar2(context, "Setting", false, () => null, false),
            body: Text("Home")));
  }
}

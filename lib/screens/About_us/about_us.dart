import 'package:flutter/material.dart';
import '../../widgets/app_bar/my_app_bar_2.dart';
import '../../widgets/spacer.dart';
import '../Navigation/MyDrawer.dart';
import 'about_wigdet.dart';

class about_us extends StatelessWidget {
  final Map UserData;
  final Map AdminData;

  const about_us({Key? key, required this.UserData, required this.AdminData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: MyDrawer(
          UserData: UserData,
          AdminData: AdminData,
        ),
        appBar: MyAppBar2(context, "About us", false, () {}, false),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading("FWM System:"),
              paragraph(
                  """* Food waste management system for restaurants and food businesses. 
* Provides customers with real-time food waste management information.
* Provides restaurants and food businesses with a method to effectively manage food waste in their stores.
* Includes a mobile app that allows users to track food waste, manage donations and communicate with nonprofits."""),
              spacer(12.0, 0.0),
              spacer(12.0, 0.0),
              heading("Contact:"),
              rowpara("Phone No:  ", "03XX-XXXXXXXXX"),
              rowpara("Email:         ", "abc@gmail.com"),
              // rowpara("Website:     ", "https://portfolio-2021.web.app/"),
            ],
          ),
        ),
      ),
    );
  }
}

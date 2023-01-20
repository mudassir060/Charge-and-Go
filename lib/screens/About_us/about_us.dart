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
              heading("Charge & Go:"),
              paragraph(
                  """Charge and go is an electric bike convenient, and sustainable to move through the 
university. all it takes is to download its android application scan the QR code on it 
to activate it and start your ride. You can drive everywhere within the coverage 
area. you can easily park the Bike at a suitable location and end your trip using the 
app. charge and go is an efficient, fun way to travel around."""),
              spacer(12.0, 0.0),
              spacer(12.0, 0.0),
              heading("Contact:"),
              rowpara("Phone No:  ", "+923362595099"),
              rowpara("Email:         ", "chargeandgosau@gmail.com"),
              // rowpara("Website:     ", "https://portfolio-2021.web.app/"),
            ],
          ),
        ),
      ),
    );
  }
}

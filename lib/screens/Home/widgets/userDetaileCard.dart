import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/icons.dart';
import '../../../constants/style.dart';
import '../../../widgets/spacer.dart';
import 'package:intl/intl.dart';

class userDetaileCard extends StatelessWidget {
  final Map UserData;

  const userDetaileCard({Key? key, required this.UserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning.';
      }
      if (hour < 17) {
        return 'Good Afternoon.';
      }
      return 'Good Evening.';
    }
    // print("================>${DateTime.parse(UserData["BookRideTime"])}");
    // print("================>${DateTime.parse(UserData["StopRideTime"])}");

    String start_time = UserData["BookRideTime"].toString(); // or if '24:00'
    String end_time = UserData["StopRideTime"].toString(); // or if '12:00

    var format = DateFormat("dd MM yyyy HH:mm");
    var start = format.parse(start_time);
    var end = format.parse(end_time);
    var hour = end.difference(start).inHours;
    var min = end.difference(start).inMinutes;
    var time;
    if (hour >= 1) {
      time = "$hour hr";
    } else {
      time = "$min min";
    }
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: active,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 2,
            child: UserData["UserProfile"] == null
                ? const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(sellerIcon),
                  )
                : CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(UserData["UserProfile"])),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting().toUpperCase(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "         ${UserData["username"]}".toUpperCase(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "                    (${UserData["rollNo"]})",
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: active,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.access_time_sharp),
                        spacer(0.0, 10.0),
                        Text("$time"),
                        spacer(0.0, 100.0),
                        Icon(Icons.directions_bike_sharp),
                        spacer(0.0, 10.0),
                        Text("data"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

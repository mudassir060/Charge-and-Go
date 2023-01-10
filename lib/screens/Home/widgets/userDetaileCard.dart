import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/icons.dart';
import '../../../constants/style.dart';
import '../../../widgets/spacer.dart';

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
                    greeting(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Hi! Welcome ${UserData["username"]}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  spacer(10.0, 0.0),
                  Text(
                    "(${UserData["rollNo"]})",
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
                        Text("${UserData["lastRideTime"]}"),
                        spacer(0.0, 100.0),
                        Icon(Icons.directions_bike_sharp),
                        Text("data"),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

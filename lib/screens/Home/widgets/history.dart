import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../../constants/images.dart';
import '../../../constants/style.dart';
import '../../../widgets/loadingwidget.dart';
import '../../../widgets/spacer.dart';

class history extends StatefulWidget {
  final Map UserData;

  history({Key? key, required this.UserData}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _historyStream = FirebaseFirestore.instance
        .collection('History')
        // .orderBy('Date', descending: true)
        .where('UID', isEqualTo: widget.UserData["UID"])
        // .limitToLast(2)l
        .snapshots();
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _historyStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: const [
              Text('Something went wrong'),
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: loadingwidget(
              color: Colors.black,
            ),
          );
        }
        if (snapshot.data?.size == 0) {
          return Center(child: const Text("No data found"));
        }
        return ListView(
          reverse: true,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: ScrollController(),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            String start_time =
                data["BookRideTime"].toString(); // or if '24:00'
            String end_time = data["StopRideTime"].toString(); // or if '12:00

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
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                  color: active,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(logo),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bike No: ${data['barcode']}"),
                        spacer(5.0, 0.0),
                        data["startLatitude"] != null &&
                                data["startLongitude"] != null &&
                                data["endLatitude"] != null &&
                                data["endLongitude"] != null &&
                            data["startLongitude"] !=
                                data["endLongitude"]
                            ? Text("Distance: ${Geolocator.distanceBetween(
                                data["startLatitude"],
                                data["startLongitude"],
                                data["endLatitude"],
                                data["endLongitude"],
                              ).toString().substring(0, 5)}")
                            : const Text("Null"),
                        spacer(5.0, 0.0),
                        Text("Time: $time"),
                        spacer(5.0, 0.0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    ));
  }
}

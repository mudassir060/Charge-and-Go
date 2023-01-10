import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: ScrollController(),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left:10, right: 10,top:10),
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
                        Text("Qr No: ${data['barcode']}"),spacer(5.0,0.0),
                        Text("Booked Time: ${data['BookRideTime']}"),spacer(5.0,0.0),
                        Text("End Time: ${data['StopRideTime']}"),spacer(5.0,0.0),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/loadingwidget.dart';

class history extends StatelessWidget {
  final Map UserData;
  history({Key? key, required this.UserData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _historyStream = FirebaseFirestore.instance
        .collection('History')
    // .orderBy('Date', descending: true)
        .where('UID', isEqualTo: UserData["UID"])
    // .limitToLast(2)l
        .snapshots();

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _historyStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
              child: Column(
            children: [
              Text('Something went wrong'),
            ],
          ));
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
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: ScrollController(),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return  Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: active,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),);
          }).toList(),
        );
      },
    ));
  }
}

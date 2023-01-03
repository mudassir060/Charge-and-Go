import 'package:charge_go/widgets/smallbutton.dart';
import 'package:charge_go/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class drop_button extends StatefulWidget {
  // final DoString Coll, Doc, disable
  final String Coll;
  final Doc;
  final bool disable;

  const drop_button(
      {Key? key, required this.Coll, this.Doc, required this.disable})
      : super(key: key);

  @override
  State<drop_button> createState() => _drop_buttonState();
}

class _drop_buttonState extends State<drop_button> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.black45,
        ),
        elevation: 20,
        enabled: true,
        onSelected: (value) async {
          if (value == 1) {
            disable() async {
              Navigator.pop(context);
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              await firestore.collection(widget.Coll).doc(widget.Doc).update({
                "disable": widget.disable,
              });
              snackbar('${widget.disable ? "Enable" : "Disable"}  Sucessfuly');
            }

            AlertDialog alert = AlertDialog(
              content: Text(
                  "Are you sure you want to ${widget.disable ? "Disable" : "Enable"}"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    smallbutton("Done", () {
                      disable();
                    }),
                    smallbutton("Cancel", () {
                      Navigator.pop(context);
                    }),
                  ],
                )
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
          if (value == 2) {
            delete() async {
              Navigator.pop(context);
              FirebaseFirestore firestore = FirebaseFirestore.instance;
              await firestore
                  .collection(widget.Coll)
                  .doc(widget.Doc)
                  .delete()
                  .then((value) => snackbar("Delete successfully"))
                  .catchError((onError) => snackbar(onError.toString()));
            }

            AlertDialog alert = AlertDialog(
              // title: Center(child: Text("Error")),
              content: Text("Are you sure you want to Delete"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    smallbutton("Done", () {
                      delete();
                    }),
                    smallbutton("Cancel", () {
                      Navigator.pop(context);
                    }),
                  ],
                )
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                child: widget.disable ? Text("Disable") : Text("Enable"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Delete"),
                value: 2,
              ),
            ]);
  }
}

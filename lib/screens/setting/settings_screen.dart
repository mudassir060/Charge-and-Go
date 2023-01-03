import 'package:flutter/material.dart';
import '../../constants/icons.dart';
import '../../constants/style.dart';
import '../../widgets/app_bar/my_app_bar_2.dart';
import '../Navigation/MyDrawer.dart';
import 'updata_data.dart';
import 'change_password.dart';
import 'upload_pic.dart';

class settings_screen extends StatefulWidget {
  final Map UserData;
  final Map AdminData;

  const settings_screen(
      {Key? key, required this.UserData, required this.AdminData})
      : super(key: key);

  @override
  State<settings_screen> createState() => _settings_screenState();
}

class _settings_screenState extends State<settings_screen> {
  final TextEditingController inputcontroller =
      TextEditingController();

  Widget singlebuildcontainer({
    required String titel,
    required Null Function() fun,
    required Icon icons,
    required String subtitel,
  }) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xfffeeaf4),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icons,
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: SizedBox(
                width: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titel,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      "Change Your $subtitel",
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  inputcontroller.text = titel;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                            elevation: 50,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Enter Your New $subtitel',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: seconderyColor,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: inputcontroller,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      fillColor: Colors.black.withOpacity(0.6),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      // labelText: "$subtitel",
                                      contentPadding: const EdgeInsets.only(
                                          top: 0.0, bottom: 0.0),
                                      labelStyle: const TextStyle(fontSize: 16),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Pleae Enter $subtitel";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: seconderyColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            )),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: seconderyColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            )),
                                        onPressed: () {
                                          fun();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Done',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: seconderyColor,
                ))
          ],
        ),
      ),
    );
  }

  bool ImageUploading = false;

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
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 55,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: widget.UserData["UserProfile"] != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      "${widget.UserData["UserProfile"]}"),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: AssetImage(sellerIcon),
                                  fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          singlebuildcontainer(
                            titel: "${widget.UserData["username"]}",
                            fun: () {
                              updata_data(context, widget.UserData,widget.AdminData, "username",
                                  inputcontroller.text);
                            },
                            icons: const Icon(
                              Icons.person,
                              color: seconderyColor,
                            ),
                            subtitel: 'Name',
                          ),
                          // singlebuildcontainer(
                          //     titel: "${widget.UserData["registration"]}",
                          //     fun: () {
                          //       updata_data(context, widget.UserData,
                          //           "registration", inputcontroller.text);
                          //     },
                          //     icons: const Icon(
                          //       Icons.school,
                          //       color: seconderyColor,
                          //     ),
                          //     subtitel: 'Student ID'),
                          singlebuildcontainer(
                              titel: "${widget.UserData["PhoneNo"]}",
                              fun: () {
                                updata_data(context, widget.UserData,widget.AdminData, "PhoneNo",
                                    inputcontroller.text);
                              },
                              icons: const Icon(
                                Icons.phone,
                                color: seconderyColor,
                              ),
                              subtitel: 'Phone No'),
                          singlebuildcontainer(
                              titel: "${widget.UserData["address"]}",
                              fun: () {
                                updata_data(context, widget.UserData,widget.AdminData, "address",
                                    inputcontroller.text);
                              },
                              icons: const Icon(
                                Icons.location_on_outlined,
                                color: seconderyColor,
                              ),
                              subtitel: 'Address'),
                          // singlebuildcontainer(
                          //     titel: "${widget.UserData["password"]}",
                          //     subtitel: "Password",
                          //     fun: () {
                          //       change_password(context, widget.UserData["email"],
                          //           widget.UserData);
                          //     },
                          //     icons: const Icon(
                          //       Icons.password,
                          //       color: seconderyColor,
                          //     )),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
              Positioned(
                top: 85,
                left: 200,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 20,
                    child: ImageUploading
                        ? CircularProgressIndicator()
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                ImageUploading = true;
                              });
                              upload_pic(context, widget.UserData,widget.AdminData,);
                            },
                            icon: Icon(
                              Icons.camera,
                              color: seconderyColor,
                            ))
                    // child: Icon(Icons.camera),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

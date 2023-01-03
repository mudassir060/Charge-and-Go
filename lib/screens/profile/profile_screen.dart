import 'package:charge_go/screens/profile/widgets/header/seller_header.dart';
import 'package:charge_go/screens/profile/widgets/log_out.dart';
import 'package:flutter/material.dart';
import 'widgets/detail_field/detail_field.dart';

class ProfileScreen extends StatefulWidget {
  final Map UserData;
  final Map AdminData;

  const ProfileScreen({required this.UserData, required this.AdminData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar2(context, "Profile", false, () {}, false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [log_out(widget.AdminData)])),
            SellerHeader(UserData: widget.UserData,),
            // const SizedBox(height: 20),
            DetailField(
                title: "Name",
                text: "${widget.UserData["username"]}",
                icon: Icons.person),
            DetailField(
                title: "Email",
                text: "${widget.UserData["email"]}",
                icon: Icons.alternate_email,
                isYellow: true),
            DetailField(
              title: "address",
              text: "${widget.UserData["address"]}",
              icon: Icons.numbers,
            ),
            DetailField(
                title: "Phone No",
                text: "${widget.UserData["PhoneNo"]}",
                icon: Icons.call,
                isYellow: true),
          ],
        ),
      ),
    );
  }
}

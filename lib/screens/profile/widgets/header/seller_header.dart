import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants/icons.dart';
import '../../../../constants/style.dart';
import 'widgets/header_container.dart';

class SellerHeader extends StatefulWidget {
final Map UserData;
  const SellerHeader({ required this.UserData});

  @override
  State<SellerHeader> createState() => _SellerHeaderState();
}

class _SellerHeaderState extends State<SellerHeader> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      // Todo show error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 150,
        ),
        Positioned(
          top: 25,
          child: Row(
            children: [
              HeaderContainer(
                  onTap: () {
                  },
                  title: "",
                  value: 02,
                  // isAdSold: true,
              ),
              HeaderContainer(onTap: () {}, title: "", value: 08),
            ],
          ),
        ),
        Positioned(
            bottom: 30,
            child:  CircleAvatar(
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
            ),),

      ],
    );
  }
}

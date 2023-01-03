import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/images.dart';

class Expire extends StatelessWidget {
  final String url;
  const Expire({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> download() async {
      final Uri _url = Uri.parse(url);
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      }
    }
    double height = MediaQuery.of(context).size.height;

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              image: AssetImage(ghost)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Whoops your app has Expired.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 70.0, right: 70.0, top: 10, bottom: 20),
            child: Text(
                "Download the latest version by clicking the button down below.", textAlign: TextAlign.center,),
          ),
          InkWell(
            onTap: download,
            child: Container(
              height: height * 0.060,
              width: width * 0.6,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  "Download",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
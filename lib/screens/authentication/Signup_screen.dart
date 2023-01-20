import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/icons.dart';
import '../../constants/style.dart';
import '../../widgets/snackbar.dart';
import 'button.dart';
import 'login_screen.dart';

class Signup_screen extends StatefulWidget {
  final Map admindata;

  const Signup_screen({Key? key, required this.admindata}) : super(key: key);

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonenocontroller = TextEditingController();
  final TextEditingController rollNocontroller = TextEditingController();
  final TextEditingController userpasswordcontroller = TextEditingController();
  bool isCheck = false;
  bool NoData = false;
  bool looding = false;

  void register() async {
    setState(() {
      looding = true;
    });
    final String username = usernamecontroller.text;
    final String rollNo = rollNocontroller.text;
    final String useremail = emailcontroller.text.trim();
    final String PhoneNo = phonenocontroller.text;
    final String userpassword = userpasswordcontroller.text;

    // final String username = "Lovely Mian";
    // final String  rollNo = "2019-Cs-642";
    // final String useremail = "mudassirmukhtar4@gmail.com";
    // final String PhoneNo = "03454335400";
    // final String userpassword = "qwerty";

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      if (username != '' &&
          useremail != '' &&
          PhoneNo != '' &&
          rollNo != '' &&
          userpassword != '') {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd MM yyyy HH:mm').format(now);
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: useremail, password: userpassword);
        await firestore.collection("users").doc(user.user!.uid).set({
          "UID": user.user!.uid,
          "username": username,
          "email": useremail,
          "rollNo": rollNo,
          "PhoneNo": PhoneNo,
          "password": userpassword,
          "JoinDate": formattedDate,
          "BookRideTime": formattedDate,
          "StopRideTime": formattedDate,
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => login_screen(
              admindata: widget.admindata,
            ),
          ),
        );
      } else {
        snackbar("Please fill all text field");
        setState(() {
          NoData = true;
        });
      }
    } catch (e) {
      snackbar(e.toString());
    }
    setState(() {
      looding = false;
    });
  }

  @override
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 30,
              // ),
              // SizedBox(
              //     height: 180,
              //     child: Image.asset(storeImage, fit: BoxFit.cover)),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width - 30,
                decoration: BoxDecoration(
                    color: active,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset(userIcon, fit: BoxFit.cover)),
                            SizedBox(
                              width: 220,
                              child: TextField(
                                controller: usernamecontroller,
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: "Name"),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset(email_icon, fit: BoxFit.cover)),
                            SizedBox(
                              width: 220,
                              child: TextField(
                                controller: emailcontroller,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  hintText: "Email",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(rollNo_icon,
                                    fit: BoxFit.cover)),
                            SizedBox(
                              width: 220,
                              child: TextFormField(
                                controller: rollNocontroller,
                                decoration: const InputDecoration(
                                  hintText: 'Registration No',
                                ),
                                onSaved: (String? value) {},
                                validator: (String? value) {
                                  return (value?.contains('-') == true &&
                                          value?.contains('2k') == true &&
                                          value?.length == 12)
                                      ? null
                                      : 'Use right format 2k18-itc-221';
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset(phoneIcon, fit: BoxFit.cover)),
                            SizedBox(
                              width: 220,
                              child: TextField(
                                controller: phonenocontroller,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  hintText: "Phone Number",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset(lockIcon, fit: BoxFit.cover)),
                            SizedBox(
                              width: 220,
                              child: TextField(
                                controller: userpasswordcontroller,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  hintText: "Password",
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 15),

                        // // // // // // // // // // //Privacy Policy // // // // // // // // // //

                        const SizedBox(
                          height: 20,
                        ),
                        large_button(
                            width: width,
                            name: "Sign Up",
                            function: () {
                              register();
                            },
                            loading: looding),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 1,
                                width: 100,
                                color: Colors.grey,
                              ),
                              const Text(
                                "OR",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 1,
                                width: 100,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        large_button(
                            width: width,
                            name: "Login Now",
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login_screen(
                                            admindata: widget.admindata,
                                          )));
                            },
                            loading: false),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

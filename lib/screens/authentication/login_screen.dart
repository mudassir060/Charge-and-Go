import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/icons.dart';
import '../../constants/style.dart';
import '../../widgets/snackbar.dart';
import '../Home/HomeScreen.dart';
import 'ForgetPassword.dart';
import 'Signup_screen.dart';
import 'button.dart';

class login_screen extends StatefulWidget {
  final Map admindata;

  const login_screen({Key? key, required this.admindata}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  bool looding = false;
  bool _obscureText = true;

  FlutterSecureStorage storage = const FlutterSecureStorage();
  final TextEditingController useremailcontroller = TextEditingController();
  final TextEditingController userpasswordcontroller = TextEditingController();

  void register() async {
    setState(() {
      looding = true;
    });
    var UserData;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String useremail = useremailcontroller.text.trim();
    final String userpassword = userpasswordcontroller.text;
    try {
      if (useremail != '' && userpassword != '') {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: useremail, password: userpassword);
        final DocumentSnapshot snapshot =
            await firestore.collection("users").doc(user.user?.uid).get();
        storage.write(key: "UID", value: user.user?.uid);
        final data = snapshot.data();
        setState(() {
          UserData = data;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    UserData: UserData,
                    AdminData: widget.admindata,
                  )),
        );
      } else {
        snackbar("Please fill all text field");
      }
    } catch (e) {
      snackbar(e.toString());
    }
    setState(() {
      looding = false;
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
              SizedBox(
                height: 30,
              ),
              // SizedBox(
              //     height: 180, child: Image.asset(storeImage, fit: BoxFit.cover)),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Login",
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
                                  Image.asset(email_icon, fit: BoxFit.cover)),
                          SizedBox(
                            width: 220,
                            child: TextField(
                              controller: useremailcontroller,
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  // labelText: 'Phone Number',
                                  hintText: "Email"),
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
                              child: Image.asset(lockIcon, fit: BoxFit.cover)),
                          SizedBox(
                            width: 220,
                            child: TextField(
                              controller: userpasswordcontroller,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                // labelText: 'Password',
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    // color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // // // // // // // // // // //Forget Button // // // // // // // // // //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPassword()));
                              },
                              child: const Text(
                                'Forget Password',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: appBarColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      large_button(
                          width: width,
                          name: "Login",
                          loading: looding,
                          function: () {
                            register();
                          }),
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
                          name: "Sign Up Now",
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup_screen(
                                          admindata: widget.admindata,
                                        )));
                          },
                          loading: false),
                    ],
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

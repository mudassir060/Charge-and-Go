import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/snackbar.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth Auth = FirebaseAuth.instance;
  final TextEditingController useremailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void resetPassword() async {
      final String useremail = useremailcontroller.text.trim();
      print("============================>$useremail");

      await Auth.sendPasswordResetEmail(email: useremail).then((value) => {
      snackbar(
      "Sent email Successfully. Check your email."),
          Navigator.of(context).pop()
    }).catchError((e){snackbar(
      e.code);
      });

    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: useremailcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  // labelText: 'Email',
                  hintText: "Email"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  'Sent Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              onPressed: resetPassword,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

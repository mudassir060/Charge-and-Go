// import 'package:firebase_auth/firebase_auth.dart';
// import '../../widgets/snackbar.dart';
// import 'upload_data.dart';
//
// change_password(context, email, UserData, AdminData) async {
//   try {
//     await FirebaseAuth.instance
//         .sendPasswordResetEmail(email: email)
//         .then((value) {
//       snackbar("Check Your Email");
//     });
//     upload_data(context, UserData, AdminData);
//   } catch (e) {
//     print("========Error===>$e");
//     snackbar(e.toString());
//   }
// }

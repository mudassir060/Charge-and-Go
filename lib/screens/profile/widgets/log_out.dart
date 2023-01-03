import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../constants/icons.dart';
import '../../../constants/style.dart';
import '../../../widgets/snackbar.dart';
import '../../authentication/login_screen.dart';

class log_out extends StatelessWidget {
  final Map AdminData;

  const log_out(this.AdminData);

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage storage = const FlutterSecureStorage();

    return InkWell(
      onTap: () async {
        await storage.delete(key: "UID");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => login_screen(admindata: AdminData)));
        snackbar("Log Out Sccessfully");

      },
      child: Container(
        width: 130,
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: lightBlue, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            // SizedBox(height: 20, width: 20, child: Image.asset(editIcon)),
            Image.asset(
              power_off,
              fit: BoxFit.contain,
              width: 40,
            ),
            const SizedBox(width: 10),
            const Text("Log Out")
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class loadingwidget extends StatelessWidget {
  final  color;
  const loadingwidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: color,
      size: 50.0,
    );
  }
}

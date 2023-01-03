// // import 'dart:convert';
// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/services.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:webview_flutter_plus/webview_flutter_plus.dart';
// //
// // class localweb extends StatefulWidget {
// //   const localweb({Key? key}) : super(key: key);
// //
// //   @override
// //   State<localweb> createState() => _localwebState();
// // }
// //
// // class _localwebState extends State<localweb> {
// //   late WebViewPlusController _controller;
// //
// //   Future<void> loadHtmlFromAssets(String filename, controller) async {
// //     String fileText = await rootBundle.loadString(filename);
// //     controller.loadUrl(Uri.dataFromString(fileText,
// //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
// //         .toString());
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WebViewPlus(
// //       initialUrl: 'assets/webfile/pdftodocx.html',
// //       javascriptMode: JavascriptMode.unrestricted,
// //       onWebViewCreated: (webViewController) async {
// //         _controller = webViewController;
// //         // await loadHtmlFromAssets('assets/webfile/pdftodocx.html', _controller);
// //       },
// //     );
// //   }
// // }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_plus/webview_flutter_plus.dart';
//
// class converter_screen extends StatefulWidget {
//   const converter_screen({Key? key}) : super(key: key);
//
//   @override
//   State<converter_screen> createState() => _converter_screenState();
// }
//
// class _converter_screenState extends State<converter_screen> {
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       url: "https://www.ilovepdf.com/pdf_to_word",
//       withLocalStorage: true,
//       withZoom: true,
//       hidden: true,
//       allowFileURLs: true,
//       debuggingEnabled: true,
//       displayZoomControls: true,
//       initialChild: Container(
//         color: Colors.redAccent,
//         child: const Center(
//           child: Text('Waiting.....'),
//         ),
//       ),
//     );
//   }
// }

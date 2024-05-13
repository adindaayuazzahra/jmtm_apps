// ignore_for_file: library_private_types_in_public_api

import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

// class Webtampil extends StatefulWidget {
//   final String url;
//   final String title;
//   final AuthProvider authProvider;
//   Webtampil(
//       {Key? key,
//       required this.url,
//       required this.title,
//       required this.authProvider})
//       : super(key: key);

//   @override
//   _WebtampilState createState() => _WebtampilState();
// }

// class _WebtampilState extends State<Webtampil> {
//   late final WebViewController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(
//         Uri.parse(
//           '${widget.url}',
//         ),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: putih,
//         elevation: 0,
//         title: Text(
//           widget.title,
//           style: GoogleFonts.heebo(
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.7,
//             color: primaryColor,
//           ),
//         ),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }

class Webtampil extends StatefulWidget {
  final String url;
  final String title;
  final AuthProvider authProvider;
  const Webtampil(
      {Key? key,
      required this.url,
      required this.title,
      required this.authProvider})
      : super(key: key);

  @override
  _WebtampilState createState() => _WebtampilState();
}

class _WebtampilState extends State<Webtampil> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setNavigationDelegate(
      //   NavigationDelegate(
      //     onPageStarted: (_) {
      //       // _passDataToJavaScript();
      //     },
      //   ),
      // )
      ..loadRequest(
        Uri.parse(
            // '${widget.url}?npp=${widget.authProvider.user.user.dakar.npp}&nama=${widget.authProvider.user.user.dakar.nama}&kd_comp=${widget.authProvider.user.user.dakar.kdComp}&id_role=${widget.authProvider.user.user.id_role}&id_master_akses=${widget.authProvider.user.user.id_master_akses}&status_akses=${widget.authProvider.user.user.status_akses}&jabatan=${widget.authProvider.user.user.dajab.jabatan}',
            '${widget.url}?token=${widget.authProvider.token}&token_api=ANAKKAMPRETMAULEWAT'),
      );
    // print(widget.authProvider.user.user.id_role);
  }

  // Future<void> _passDataToJavaScript() async {
  //   await controller.runJavaScriptReturningResult(
  //     'terima_module(${widget.authProvider.token}})',
  //     // 'terima_module(${widget.authProvider.user.user.dakar.npp}, ${widget.authProvider.user.user.dakar.nama},${widget.authProvider.user.user.dakar.kdComp},${widget.authProvider.user.user.id_role},${widget.authProvider.user.user.id_master_akses}, ${widget.authProvider.user.user.status_akses}, ${widget.authProvider.user.user.dajab.jabatan})',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: putih,
        elevation: 0,
        title: Text(
          widget.title,
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
            color: primaryColor,
          ),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

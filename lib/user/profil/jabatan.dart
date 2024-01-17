// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/common/routes.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/componen/subtitle.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Jabatan extends StatefulWidget {
  const Jabatan({Key? key}) : super(key: key);

  @override
  _JabatanState createState() => _JabatanState();
}

class _JabatanState extends State<Jabatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 6,
        shadowColor: secondaryColor,
        iconTheme: const IconThemeData(color: putih),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const FaIcon(
        //       FontAwesomeIcons.clockRotateLeft,
        //       size: 20,
        //     ),
        //     onPressed: () {
        //       Routes.router.navigateTo(context, '/history_absen',
        //           transition: TransitionType.inFromRight);
        //       // ScaffoldMessenger.of(context).showSnackBar(
        //       //     const SnackBar(content: Text('This is a snackbar')));
        //     },
        //   ),
        // ],
        title: Text(
          'Jabatan',
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
            color: putih,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              Subtitle(text: 'Jabatan Aktif'),
            ],
          ),
        ),
      ),
    );
  }
}

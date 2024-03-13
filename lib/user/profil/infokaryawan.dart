import 'package:appjmtm/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Infokaryawan extends StatefulWidget {
  const Infokaryawan({Key? key}) : super(key: key);

  @override
  _InfokaryawanState createState() => _InfokaryawanState();
}

class _InfokaryawanState extends State<Infokaryawan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 6,
        centerTitle: true,
        shadowColor: secondaryColor,
        iconTheme: const IconThemeData(color: putih),
        title: Text(
          'Info Karyawan',
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
            color: putih,
          ),
        ),
      ),
    );
  }
}

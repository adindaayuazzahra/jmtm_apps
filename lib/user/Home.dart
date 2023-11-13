// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/componen/home_component.dart';
import 'package:appjmtm/componen/subtitlewithmore.dart';
import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void didChangeDependencies() {
      super.didChangeDependencies();
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchNews();
    }

    // // Dekode token untuk mendapatkan data.
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    // String nama = decodedToken['nama'];
    // String npp = decodedToken['npp'];
    // String jabatan = decodedToken['jabatan'];
    // Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "JMTM SERVICES",
              style: GoogleFonts.heebo(
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                color: putih,
              ),
            ),
            Text(
              "PT Jasamarga Tollroad Maintenance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.amber.shade400,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final newsProvider =
              Provider.of<NewsProvider>(context, listen: false);
          await newsProvider.fetchNews(); // Lakukan pembaruan data
          setState(() {}); // Perbarui tampilan
        },
        // onRefresh: () async {
        //   setState(() {
        //     isRefreshing =
        //         true; // Set the flag to indicate that the refresh is in progress
        //   });
        //   await _handleRefresh(); // Call the function to handle the refresh logic
        // },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderHome(size: size, authProvider: authProvider),
              SizedBox(
                height: 20,
              ),
              SubtitleWithMore(
                text: "Berita Teratas",
                press: () {
                  Routes.router.navigateTo(context, '/berita',
                      transition: TransitionType.fadeIn);
                },
              ),
              SizedBox(
                height: 10,
              ),
              // Berita(),
              Berita(),
              SizedBox(
                height: 200000,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

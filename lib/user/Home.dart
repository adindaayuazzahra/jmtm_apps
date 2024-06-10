// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/componen/home_component.dart';
import 'package:appjmtm/componen/subtitle.dart';
import 'package:appjmtm/componen/subtitlewithmore.dart';
import 'package:appjmtm/provider/AbsenProvider.dart';
import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/common/routes.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/user/berita/berita.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   super.initState();

  //   // final DateTime tanggalHariIni = DateTime.now();
  //   // final String formattedDate =
  //   //     DateFormat('yyyy-M-d', 'id').format(tanggalHariIni);
  //   // final absenProvider = Provider.of<AbsenProvider>(context, listen: false);
  //   // final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   // final npp = '${authProvider.user.user.dakar.npp}';
  //   // absenProvider.fetchDataAbsen(npp, formattedDate);

  //   // print('halaman home : ${absenProvider.absenData.absen.length}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: putih,
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "JMTM SERVICES ",
              style: GoogleFonts.heebo(
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                color: putih,
                fontSize: 16,
              ),
            ),
            Text(
              "PT Jasamarga Tollroad Maintenance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                // color: kuning,
                color: Colors.amber.shade500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: putih,
              size: 20,
            ),
            onPressed: () async {
              final absenProvider =
                  Provider.of<AbsenProvider>(context, listen: false);
              absenProvider.resetDataAbsen();
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();

              Routes.router.navigateTo(context, '/login',
                  transition: TransitionType.inFromRight, replace: true);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          final newsProvider =
              Provider.of<NewsProvider>(context, listen: false);
          await newsProvider.fetchNews(); // Lakukan pembaruan data
          setState(() {}); // Perbarui tampilan
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderHome(),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Subtitle(
                      text: 'Aplikasi JMTM',
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    // CONTAINER OVAL
                    HeaderMenu(),
                    SizedBox(
                      height: 50,
                    ),
                    SubtitleWithMore(
                      text: "Berita Terbaru",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeritaPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BeritaHome(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

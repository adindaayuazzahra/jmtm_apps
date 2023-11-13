// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/componen/home_component.dart';
import 'package:appjmtm/componen/subtitle.dart';
import 'package:appjmtm/componen/subtitlewithmore.dart';
import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:appjmtm/user/webview/webview.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchNews();
  }
  // void initState() {
  //   super.initState();
  //   _initializeData();
  // }

  // Future<void> _initializeData() async {
  //   final newsProvider = Provider.of<NewsProvider>(context, listen: false);
  //   await newsProvider.fetchNews();
  //   setState(() {}); // Perbarui tampilan setelah mendapatkan data
  // }

  @override
  Widget build(BuildContext context) {
    // // Dekode token untuk mendapatkan data.
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    // String nama = decodedToken['nama'];
    // String npp = decodedToken['npp'];
    // String jabatan = decodedToken['jabatan'];
    // Size size = MediaQuery.of(context).size;

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderHome(),
              SizedBox(
                height: 40,
              ),
              Subtitle(
                text: 'Aplikasi JMTM',
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 21),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 19),
                decoration: BoxDecoration(
                  color: putih,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 6),
                      blurRadius: 14,
                      color: secondaryColor.withOpacity(0.6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.computer),
                          color: secondaryColor,
                          iconSize: 40,
                          onPressed: () {},
                        ),
                        Text(
                          "IT SERVICES",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              height: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    MenuHeader(),
                    Column(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.verified_user),
                          color: secondaryColor,
                          iconSize: 38,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Webview(
                                  url:
                                      'https://e-sip.jmtm.co.id', // Ganti dengan URL yang diinginkan
                                  title:
                                      'HC JMTM', // Ganti dengan URL yang diinginkan
                                ),
                              ),
                            );
                          },
                        ),
                        Text(
                          "HC APPS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              height: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.meeting_room),
                          color: secondaryColor,
                          iconSize: 40,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Webview(
                                  url:
                                      'https://bookroom.jmtm.co.id', // Ganti dengan URL yang diinginkan
                                  title:
                                      'E-Room', // Ganti dengan URL yang diinginkan
                                ),
                              ),
                            );
                            // String url = 'https://bookroom.jmtm.co.id';
                            // String title = 'uhuyy';

                            // Routes.router.navigateTo(
                            //   context,
                            //   '/webview/$url/$title',
                            //   transition: TransitionType.fadeIn,
                            // );
                          },
                        ),
                        Text(
                          "E-Room",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              height: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
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
              Berita(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

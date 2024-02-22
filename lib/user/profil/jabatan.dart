// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/componen/subtitle.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

class Jabatan extends StatefulWidget {
  const Jabatan({Key? key}) : super(key: key);

  @override
  _JabatanState createState() => _JabatanState();
}

class _JabatanState extends State<Jabatan> {
  void _launchPDFUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    List<dynamic> sortedHisjab = List.from(authProvider.user.user.hisjab);
    sortedHisjab.sort(
        (a, b) => DateTime.parse(b.tgl_sk).compareTo(DateTime.parse(a.tgl_sk)));
    return Consumer<AuthProvider>(builder: (context, authProvider, _) {
      // Dapatkan data pengguna dari AuthProvider
      final user = authProvider.user;

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: primaryColor,
          centerTitle: true,
          elevation: 6,
          shadowColor: secondaryColor,
          iconTheme: const IconThemeData(color: putih),
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
            padding: EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jabatan Aktif',
                        style: GoogleFonts.heebo(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      // Subtitle(text: 'Jabatan Aktif'),
                      if (user.user.dajab.lampiran != '')
                        InkWell(
                          onTap: () {
                            _launchPDFUrl(
                                "http://10.8.0.4:8080/dokumen_sk/${(user.user.dajab.lampiran)}");
                          },
                          child: Text(
                            'Lihat SK Jabatan',
                            style: GoogleFonts.heebo(
                              fontStyle: FontStyle.italic,
                              color: secondaryColor,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor: secondaryColor,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 30),
                  padding: EdgeInsets.all(15),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${authProvider.user.user.dajab.jabatan} (${authProvider.user.user.dajab.grade})',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      if (user.user.dajab.seksi != '')
                        Text(
                          user.user.dajab.seksi,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.heebo(fontSize: 14),
                        ),
                      Text(
                        user.user.dajab.departemen,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.heebo(fontSize: 14),
                      ),
                      Text(
                        user.user.dakar.kd_comp,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.heebo(fontSize: 14),
                      ),
                      Text(
                        '${formatHari(user.user.dajab.tgl_sk)} - ${user.user.dajab.tgl_akhir_sk != '' ? formatHari(user.user.dajab.tgl_akhir_sk) : "Hingga saat ini"}',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.heebo(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Subtitle(text: 'Riwayat Jabatan'),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: TimelineTheme(
                    data: TimelineThemeData(
                      color: primaryColor,
                      nodePosition: 0,
                      // indicatorPosition: 0.08,
                      connectorTheme: ConnectorThemeData(
                        color: primaryColor,
                        thickness: 2,
                      ),
                      indicatorTheme: IndicatorThemeData(
                        color: primaryColor,
                        size: 12,
                      ),
                    ),
                    child: Column(
                      children: sortedHisjab.map((hisjabData) {
                        return Column(
                          children: [
                            // TIMELINE HEADER
                            TimelineTile(
                              contents: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: orange,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    '${formatHari(hisjabData.tgl_sk)} - ${formatHari(hisjabData.tgl_akhir_sk)}',
                                    style: TextStyle(
                                      color: putih,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              node: TimelineNode(
                                indicator: DotIndicator(),
                                startConnector: SolidLineConnector(
                                  endIndent: 3,
                                ),
                                endConnector: SolidLineConnector(
                                  indent: 3,
                                ),
                              ),
                            ),

                            TimelineTile(
                              node: TimelineNode(
                                overlap: true,
                                startConnector: SolidLineConnector(
                                  endIndent: 0,
                                ),
                                endConnector: SolidLineConnector(
                                  indent: 0,
                                ),
                              ),
                              contents: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 9),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    '${hisjabData.keterangan}',
                                    style: TextStyle(
                                      color: putih,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // TIMELINE DETAIL
                            TimelineTile(
                              node: TimelineNode(
                                overlap: true,
                                startConnector: SolidLineConnector(
                                  endIndent: 0,
                                ),
                                endConnector: SolidLineConnector(
                                  indent: 0,
                                ),
                              ),
                              contents: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${hisjabData.jabatan} (${hisjabData.grade})',
                                      style: GoogleFonts.heebo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text('${hisjabData.seksi}'),
                                    Text('${hisjabData.departemen}'),
                                    InkWell(
                                      onTap: () {
                                        _launchPDFUrl(
                                            "http://10.8.0.4:8080/dokumen_sk/${(hisjabData.lampiran)}");
                                      },
                                      child: Text(
                                        'Lihat SK Jabatan',
                                        style: GoogleFonts.heebo(
                                          fontStyle: FontStyle.italic,
                                          color: secondaryColor,
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                          decorationColor: secondaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

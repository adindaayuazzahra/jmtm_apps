// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/common/routes.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/componen/subtitle.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class Jabatan extends StatefulWidget {
  const Jabatan({Key? key}) : super(key: key);

  @override
  _JabatanState createState() => _JabatanState();
}

class _JabatanState extends State<Jabatan> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
              SizedBox(
                height: 10,
              ),
              Subtitle(text: 'Riwayat Jabatan'),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: TimelineTheme(
                  data: TimelineThemeData(
                    color: primaryColor,
                    nodePosition: 0,
                    indicatorPosition: 0.23,
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
                    children: [
                      TimelineTile(
                        contents: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                color: orange,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'contents',
                                    style: TextStyle(color: putih),
                                  ),
                                ),
                              ),
                              Text(
                                  'Uhuy test ahayyy'),
                            ],
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
                    ],
                  ),
                ),
              )
              // FixedTimeline.tileBuilder(
              //   textDirection: TextDirection.rtl,
              //   builder: TimelineTileBuilder.connectedFromStyle(
              //     contentsAlign: ContentsAlign.alternating,
              //     oppositeContentsBuilder: (context, index) => Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //           'opposite\ncontents opposite\ncontents opposite\ncontents opposite\ncontents'),
              //     ),
              //     contentsBuilder: (context, index) => Card(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text('Contents'),
              //       ),
              //     ),
              //     connectorStyleBuilder: (context, index) =>
              //         ConnectorStyle.solidLine,
              //     indicatorStyleBuilder: (context, index) =>
              //         IndicatorStyle.outlined,
              //     itemCount: 3,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

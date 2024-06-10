import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/provider/EducationProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:appjmtm/user/profil/infokaryawan.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    final npp = authProvider.user.user.dakar.npp;

    final educationProvider =
        Provider.of<EducationProvider>(context, listen: false);

    educationProvider.fetchPendidikan(npp);
    educationProvider.fetchPelatihan(npp);
  }

  void _launchPDFUrl(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 6,
          centerTitle: true,
          shadowColor: primaryColor,
          iconTheme: const IconThemeData(color: putih),
          title: Text(
            'Pendidikan dan Pelatihan',
            style: GoogleFonts.heebo(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7,
              color: putih,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryColor,
              ),
              child: TabBar(
                padding: EdgeInsets.all(6),
                dragStartBehavior: DragStartBehavior.start,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicatorPadding: EdgeInsets.all(5),
                indicator: BoxDecoration(
                  color: kuning,
                  borderRadius: BorderRadius.circular(30),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Pendidikan',
                      style: TextStyle(
                        color: putih,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Pelatihan',
                      style: TextStyle(
                        color: putih,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: SizedBox(
                height: size.height * 0.67,
                child: TabBarView(
                  children: <Widget>[
                    // TAB 1 PENDIDIKAN =====================
                    SingleChildScrollView(
                      child: Consumer<EducationProvider>(
                          builder: (context, educationProvider, _) {
                        if (educationProvider.hasError) {
                          return Center(
                            child: Text(educationProvider.errorMessage),
                          );
                        }

                        // final edudata = educationProvider.pelatihan;
                        List<dynamic> sortedPendidikan =
                            List.from(educationProvider.pendidikan.pendidikan);
                        if (sortedPendidikan.isNotEmpty) {
                          return Container(
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
                                children: sortedPendidikan.map((pdk) {
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
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Pendidikan ${pdk.tingkatPendidikan}',
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 9),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              'Tahun Lulus ${formatTglLahir(pdk.tahunLulus)}',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Jurusan ${pdk.jurusan} (${pdk.gelar})',
                                                style: GoogleFonts.heebo(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                  '${pdk.namaLembaga} (${pdk.negara})'),
                                              SizedBox(height: 6),
                                              InkWell(
                                                onTap: () {
                                                  if ('${pdk.linkDoc}' ==
                                                      Null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Maaf saat ini Ijazah belum tersedia. Silahkan hubungi Admin HC untuk menambahkan Ijazah.'),
                                                      ),
                                                    );
                                                  } else {
                                                    final url = Uri.parse(
                                                        "http://10.8.0.4:8080/${pdk.linkDoc}");
                                                    _launchPDFUrl(url);
                                                  }
                                                },
                                                child: Text(
                                                  'Lihat Ijazah',
                                                  style: GoogleFonts.heebo(
                                                    fontStyle: FontStyle.italic,
                                                    color: primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    decorationColor:
                                                        primaryColor,
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
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Belum Ada Riwayat Pendidikan yang Terdaftar.',
                              style: GoogleFonts.heebo(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          );
                        }
                      }),
                    ),

                    // TAB 2 PELATIHAN =====================
                    SingleChildScrollView(
                      child: Consumer<EducationProvider>(
                          builder: (context, educationProvider, _) {
                        // final edudata = educationProvider.pelatihan;
                        List<dynamic> sortedPelatihan =
                            List.from(educationProvider.pelatihan.pelatihan);

                        if (sortedPelatihan.isNotEmpty) {
                          return Container(
                            // padding: EdgeInsets.symmetric(horizontal: 14),
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
                                // padding: EdgeInsets.only(bottom: 10),
                                children: sortedPelatihan.map((plt) {
                                  // Pisahkan string berdasarkan koma dan parsing menjadi DateTime
                                  var dateStrings =
                                      '${plt.tanggalPelatihan}'.split(',');
                                  List<DateTime> dates =
                                      dateStrings.map((dateStr) {
                                    return DateFormat('dd-MM-yyyy')
                                        .parse(dateStr);
                                  }).toList();

                                  // Mengambil tanggal awal dan akhir
                                  DateTime startDate = dates
                                      .reduce((a, b) => a.isBefore(b) ? a : b);
                                  DateTime endDate = dates
                                      .reduce((a, b) => a.isAfter(b) ? a : b);

                                  // Menghitung selisih hari
                                  int differenceInDays =
                                      endDate.difference(startDate).inDays + 1;

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
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Pendidikan ${plt.nmPelatihan}',
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 9),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                              'Pelatihan ${plt.typePelatihan}',
                                              // '$differenceInDays hari (${DateFormat('d MMM yyyy', 'id').format(startDate)} - ${DateFormat('d MMM yyyy', 'id').format(endDate)})',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Dilaksanakan oleh ${plt.pelaksana}',
                                                style: GoogleFonts.heebo(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                '$differenceInDays hari (${DateFormat('d MMM yyyy', 'id').format(startDate)} - ${DateFormat('d MMM yyyy', 'id').format(endDate)})',
                                                style: GoogleFonts.heebo(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                'Di inisiatori oleh ${plt.inisiator}',
                                                style: GoogleFonts.heebo(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(height: 6),
                                              InkWell(
                                                onTap: () {
                                                  if ('${plt.lampiran}' == '') {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Maaf saat ini sertifikat belum tersedia. Silahkan hubungi Admin HC untuk menambahkan sertifikat.'),
                                                      ),
                                                    );
                                                  } else {
                                                    final url = Uri.parse(
                                                        "http://10.8.0.4:8080/sertifikat/${plt.lampiran}");
                                                    _launchPDFUrl(url);
                                                  }
                                                },
                                                child: Text(
                                                  'Lihat Sertifikat',
                                                  style: GoogleFonts.heebo(
                                                    fontStyle: FontStyle.italic,
                                                    color: primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                    decorationColor:
                                                        primaryColor,
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
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Belum Ada Pelatihan yang Diikuti.',
                              style: GoogleFonts.heebo(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          );
                        }
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

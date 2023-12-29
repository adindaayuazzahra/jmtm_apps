// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:appjmtm/provider/HistoryAbsenProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/styles.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryAbsen extends StatefulWidget {
  @override
  _HistoryAbsenState createState() => _HistoryAbsenState();
}

class _HistoryAbsenState extends State<HistoryAbsen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _resetAndFetchHistory() async {
    final absenProvider =
        Provider.of<HistoryAbsenProvider>(context, listen: false);
    absenProvider.resethis();
    await _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    final npp = '${authProvider.user.user.dakar.npp}';
    final absenProvider =
        Provider.of<HistoryAbsenProvider>(context, listen: false);
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    await absenProvider.history(npp, formattedDate);
    print('History Call: ${absenProvider.absenHis.absen.length}');
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // setState(() {
      selectedDate = picked;
      // });
      // Future.microtask(() async {
      await _resetAndFetchHistory();
      // });
    }
  }
  // DateTime selectedDate = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   _resetAndFetchHistory();
  // }

  // Future<void> _resetAndFetchHistory() async {
  //   final absenProvider =
  //       Provider.of<HistoryAbsenProvider>(context, listen: false);
  //   absenProvider.resethis();
  //   await _fetchHistory();
  // }

  // Future<void> _fetchHistory() async {
  //   var authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   final npp = '${authProvider.user.user.dakar.npp}';
  //   final absenProvider =
  //       Provider.of<HistoryAbsenProvider>(context, listen: false);
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  //   await absenProvider.history(npp, formattedDate);
  //   print('History Call: ${absenProvider.absenHis.absen.length}');
  // }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );

  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //       // String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  //       // var authProvider = Provider.of<AuthProvider>(context, listen: false);
  //       // final npp = '${authProvider.user.user.dakar.npp}';
  //       // final absenProvider =
  //       //     Provider.of<HistoryAbsenProvider>(context, listen: false);
  //       // absenProvider.resethis();
  //       // absenProvider.history(npp, formattedDate);
  //       // // print('Selected Date: $selectedDate');
  //       // // print('Formatted Date: $formattedDate');
  //       // // absenProvider.resethis();
  //       // print('Before History Call: ${absenProvider.absenHis.absen.length}');
  //       // absenProvider.history(npp, formattedDate);
  //       // print('After History Call: ${absenProvider.absenHis.absen.length}');
  //     });
  //   await _resetAndFetchHistory();
  // }
  @override
  void initState() {
    super.initState();
    _resetAndFetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryAbsenProvider>(
      builder: (context, absenProvider, _) {
        final absenData = absenProvider.absenHis;
        Size size = MediaQuery.of(context).size;

        return Scaffold(
          backgroundColor: putih,
          appBar: AppBar(
            backgroundColor: primaryColor,
            elevation: 6,
            centerTitle: true,
            shadowColor: secondaryColor,
            iconTheme: const IconThemeData(color: putih),
            title: Text(
              'Riwayat Presensi',
              style: GoogleFonts.heebo(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
                color: putih,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: secondaryColor, // Warna border
                            width: 2.0, // Lebar border
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${DateFormat('dd  MMMM  yyyy', 'id').format(selectedDate)}'
                              .toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 2),
                        ),
                      ),
                      SizedBox(height: 5),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          // width: size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ), // Atur nilai border radius sesuai keinginan
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  secondaryColor),
                            ),
                            onPressed: () {
                              _selectDate();
                            },
                            child: FaIcon(
                              FontAwesomeIcons.calendarCheck,
                              color: putih,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  SizedBox(height: 20.0),
                  if (absenData.absen.length != 0)
                    for (var absen in absenData.absen)
                      Container(
                        padding: EdgeInsets.all(12),
                        // surfaceTintColor: secondaryColor,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                            color: putih,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                                // spreadRadius: 1,
                              )
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Ganti nilai sesuai keinginan Anda
                              child: Image.network(
                                "http://192.168.2.65:8000/${absen.fotoLink}",
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PRESENSI ${absen.status == "0" ? "Masuk" : "Keluar"}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: absen.status == "0"
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Container(
                                  width: size.width * 0.57,
                                  child: Text(
                                    '${absen.alamat}',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.heebo(
                                      height: 1.1,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '${absen.status == "0" ? formatHari(absen.masuk) + " - " + formatDateTime(absen.masuk) : formatHari(absen.keluar) + " - " + formatDateTime(absen.keluar)}',
                                  style: GoogleFonts.heebo(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                // Text(
                                //   '${absen.status == "0" ? formatDateTime(absen.masuk) : formatDateTime(absen.keluar)}',
                                //   style: GoogleFonts.heebo(
                                //       fontWeight: FontWeight.w500, height: 1),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      )
                  else
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      alignment: Alignment.center,
                      child:
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     const Text(
                          //       'Tidak Ada Data',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 16,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 9,
                          //     ),
                          Lottie.asset(
                        'assets/lottie/nodata.json',
                      ),
                      //   ],
                      // ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

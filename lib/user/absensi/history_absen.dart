// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:appjmtm/model/Absen.dart';
import 'package:appjmtm/provider/HistoryAbsenProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryAbsen extends StatefulWidget {
  const HistoryAbsen({super.key});

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
    final npp = authProvider.user.user.dakar.npp;
    final absenProvider =
        Provider.of<HistoryAbsenProvider>(context, listen: false);
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    await absenProvider.history(npp, formattedDate);
    // print('History Call: ${absenProvider.absenHis.absen.length}');
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

  @override
  void initState() {
    super.initState();
    _resetAndFetchHistory();
  }

  @override
  Widget build(BuildContext context) {
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
      body:
          Consumer<HistoryAbsenProvider>(builder: (context, absenProvider, _) {
        final absenData = absenProvider.absenHis;
        return SingleChildScrollView(
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
                        DateFormat('dd  MMMM  yyyy', 'id')
                            .format(selectedDate)
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
                if (absenData.absen.isNotEmpty)
                  for (var absen in absenData.absen)
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          DetailAbsen(context, absen);
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        visualDensity: VisualDensity(vertical: 2),
                        horizontalTitleGap: 12,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Ganti nilai sesuai keinginan Anda
                          child: Image.network(
                            "http://10.8.0.4:8000/${absen.fotoLink}",
                            height: 500,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        subtitle: Text(
                          '${absen.status == "0" ? "${formatHari(absen.masuk)} - ${formatDateTime(absen.masuk)}" : "${formatHari(absen.keluar)} - ${formatDateTime(absen.keluar)}"}',
                          style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                            Text(
                              '${absen.alamat}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, height: 1.2),
                            ),
                          ],
                        ),
                      ),
                    )
                else
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        );
      }),
    );
  }

  Future<dynamic> DetailAbsen(BuildContext context, Absen absen) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'PRESENSI ${absen.status == "0" ? "Masuk" : "Keluar"}'
                .toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: absen.status == "0" ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // FOTO
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "http://10.8.0.4:8000/${absen.fotoLink}",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 15),
                // LOKASI ALAMAT
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.mapPin,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Lokasi',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${absen.alamat}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 12, height: 1.2),
                ),
                // TANGGAL
                SizedBox(height: 10),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.calendar,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Tanggal',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${absen.status == "0" ? "${formatHari(absen.masuk)}" : "${formatHari(absen.keluar)}"}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 12, height: 1.2),
                ),
                SizedBox(height: 10),
                // WAKTU
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      size: 14,
                      color: primaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Waktu',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${absen.status == "0" ? "${formatDateTime(absen.masuk)}" : "${formatDateTime(absen.keluar)}"}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 12, height: 1.2),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

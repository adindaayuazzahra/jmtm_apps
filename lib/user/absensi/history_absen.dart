// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:appjmtm/provider/AbsenProvider.dart';
import 'package:appjmtm/provider/HistoryAbsenProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryAbsen extends StatefulWidget {
  const HistoryAbsen({Key? key}) : super(key: key);

  @override
  _HistoryAbsenState createState() => _HistoryAbsenState();
}

class _HistoryAbsenState extends State<HistoryAbsen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('d MMM y', 'id').format(selectedDate);

        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        final npp = '${authProvider.user.user.dakar.npp}';
        final absenProvider =
            Provider.of<HistoryAbsenProvider>(context, listen: false);
        absenProvider.resethis();
        absenProvider.history(npp, formattedDate);
        print('Selected Date: $selectedDate');
        print('Formatted Date: $formattedDate');
        // absenProvider.resethis();
        print('Before History Call: ${absenProvider.absenHis.absen.length}');
        absenProvider.history(npp, formattedDate);
        print('After History Call: ${absenProvider.absenHis.absen.length}');
      });
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
              'Presensi',
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
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                  ),
                  SizedBox(width: 20.0),
                  Container(
                    width: size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text('Pilih Tanggal'),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  if (absenData.absen.length != 0)
                    for (var absen in absenData.absen)
                      Card(
                        color: putih,
                        surfaceTintColor: secondaryColor,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Ganti nilai sesuai keinginan Anda
                              child: Image.network(
                                "http://192.168.2.65:8000/${absen.fotoLink}",
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                Container(
                                  width: size.width * 0.54,
                                  child: Text(
                                    '${absen.alamat}',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.heebo(
                                      height: 1,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${absen.status == "0" ? absen.masuk : absen.keluar}',
                                  style: GoogleFonts.heebo(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Maaf, kamu belum melakukan presensi.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Lottie.asset(
                            'assets/lottie/silang.json',
                          ),
                        ],
                      ),
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

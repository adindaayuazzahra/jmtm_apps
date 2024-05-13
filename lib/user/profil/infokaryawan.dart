import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Infokaryawan extends StatefulWidget {
  const Infokaryawan({Key? key}) : super(key: key);

  @override
  _InfokaryawanState createState() => _InfokaryawanState();
}

class _InfokaryawanState extends State<Infokaryawan> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: secondaryColor,
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
                      'Pribadi',
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
                      'Kepegawaian',
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
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Detailprofil(
                            header: 'Nama',
                            isi: '${authProvider.user.user.dakar.nama}',
                            // ikon: FontAwesomeIcons.solidUser,
                          ),
                          Detailprofil(
                            header: 'Jenis Kelamin',
                            isi: '${authProvider.user.user.dakar.jenisKelamin}',
                            // ikon: FontAwesomeIcons.idCard,
                          ),
                          Detailprofil(
                            header: 'Agama',
                            isi: '${authProvider.user.user.dakar.agama}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Tempat, Tanggal Lahir',
                            isi:
                                '${authProvider.user.user.dakar.tempatLahir}, ${formatTglLahir(authProvider.user.user.dakar.tglLahir)}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Alamat Tinggal',
                            isi: '${authProvider.user.user.dakar.alamat}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'No. KTP',
                            isi: '${authProvider.user.user.dakar.ktp}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Alamat KTP',
                            isi: '${authProvider.user.user.dakar.alamatKtp}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'No. Telepon',
                            isi: '${authProvider.user.user.dakar.telpon}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Email',
                            isi: '${authProvider.user.user.dakar.email}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Email Kantor',
                            isi: '${authProvider.user.user.dakar.emailKantor}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'No. BPJS',
                            isi:
                                '${authProvider.user.user.dakar.bpjsKesehatan}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'No. BPJS Ketenagakerjaan',
                            isi: '${authProvider.user.user.dakar.bpjsTk}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'No. NPWP',
                            isi: '${authProvider.user.user.dakar.npwp}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Status Diri',
                            isi: '${authProvider.user.user.dakar.statusDiri}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          // SizedBox(
                          //   height: 12,
                          // ),
                          // Text(
                          //   '${authProvider.user.user.dakar.alamatKtp}',
                          //   // ikon: FontAwesomeIcons.handsHolding,
                          // ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Detailprofil(
                            header: 'Kode Comp',
                            isi: '${(authProvider.user.user.dakar.kdComp)}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Tanggal Bergabung',
                            isi:
                                '${formatTglLahir(authProvider.user.user.dakar.tglMasuk)}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Asal Penugasan',
                            isi:
                                '${authProvider.user.user.dakar.asalPenugasan}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Status Kepegawaian',
                            isi:
                                '${authProvider.user.user.dakar.statusPegawai}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Tanggal Keluar',
                            isi: '${authProvider.user.user.dakar.tglKeluar}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                          Detailprofil(
                            header: 'Alasan Keluar',
                            isi: '${authProvider.user.user.dakar.alasanKeluar}',
                            // ikon: FontAwesomeIcons.handsHolding,
                          ),
                        ],
                      ),
                    ),
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

class Detailprofil extends StatelessWidget {
  const Detailprofil({
    super.key,
    // required this.authProvider,
    required this.header,
    required this.isi,
    // required this.ikon,
  });
  final String header;
  final String isi;
  // final IconData ikon;
  // final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          header,
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 16,
          ),
        ),
        Text(
          isi,
          style: GoogleFonts.heebo(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 1,
          decoration: BoxDecoration(color: Colors.black),
        )
      ],
    );
  }
}

String formatTglLahir(String dateTimeString) {
  if (dateTimeString.isNotEmpty) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    return DateFormat('d MMMM yyyy', 'id').format(parsedDateTime);
  } else {
    return 'Tanggal tidak valid';
  }
}

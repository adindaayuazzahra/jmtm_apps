// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'package:appjmtm/provider/HistoryAbsenProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/styles.dart';
import 'package:appjmtm/user/Home.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:appjmtm/user/profil.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import '../provider/AbsenProvider.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    final DateTime tanggalHariIni = DateTime.now();
    final String formattedDate =
        DateFormat('yyyy-M-d', 'id').format(tanggalHariIni);
    final absenProvider = Provider.of<AbsenProvider>(context, listen: false);
    final historyAbsenProvider =
        Provider.of<HistoryAbsenProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final npp = '${authProvider.user.user.dakar.npp}';
    absenProvider.fetchDataAbsen(npp, formattedDate);
    historyAbsenProvider.history(npp, formattedDate);
    super.initState();
    checkConnectivity();
    setState(() {
      _pages = [
        Home(),
        Profil(),
        Absensi(),
      ];
    }); // Buat fungsi getToken untuk mendapatkan token
  }

  bool isConnected = true;

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = (connectivityResult != ConnectivityResult.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return isConnected
        ? WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return false;
            },
            child: Scaffold(
              body: _pages[_currentIndex],
              bottomNavigationBar: TitledBottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                curve: Curves.easeInToLinear,
                activeColor: secondaryColor,
                inactiveColor: kuning,
                enableShadow: true,
                indicatorHeight: 5,
                items: [
                  TitledNavigationBarItem(
                    title: Text(
                      'Beranda',
                      style: TextStyle(
                        // fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 1.8,
                        color: Colors.black,
                      ),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.road,
                      color: kuning,
                    ),
                  ),
                  TitledNavigationBarItem(
                    title: Text(
                      'Presensi',
                      style: TextStyle(
                        // fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 1.8,
                        color: Colors.black,
                      ),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.userClock,
                      color: kuning,
                    ),
                  ),
                  TitledNavigationBarItem(
                    title: Text(
                      'Profil',
                      style: TextStyle(
                        // fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        height: 1.8,
                        color: Colors.black,
                      ),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.helmetSafety,
                      color: kuning,
                    ),
                  ),
                ],
              ),
            ),
            // ),
          )
        : Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/noconnection.json'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Tidak Ada Koneksi Internet. \nMohon Periksa Kembali Koneksi Anda.'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1.1),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:appjmtm/styles.dart';
import 'package:appjmtm/user/Home.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:appjmtm/user/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // String _token = "";
  int _currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Ambil token dari SharedPreferences atau sumber data lainnya
    setState(() {
      // _token = token; // Simpan token ke _token
      _pages = [Home(), Absensi(), Profil()];
    }); // Buat fungsi getToken untuk mendapatkan token
  }

  // void getToken() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // String token = prefs.getString('token') ?? "";
  //   setState(() {
  //     // _token = token; // Simpan token ke _token
  //     _pages = [Home(), Absensi(), Profil()];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Ini akan menutup aplikasi sepenuhnya.
        return false; // false agar tombol kembali tidak melakukan apa pun
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
          // inactiveStripColor: secondaryColor.withOpacity(0.5),
          indicatorHeight: 5,
          // height: 50,
          // inactiveStripColor: orange,
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
                'Absensi',
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

        ///////////////////////////////////////////////// INI YANG LAMA
        // Container(
        //   margin: EdgeInsets.all(10),
        //   height: size.width * .155,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(.15),
        //         blurRadius: 30,
        //         offset: Offset(0, 10),
        //       ),
        //     ],
        //     borderRadius: BorderRadius.circular(50),
        //   ),
        //   child:
        //     BottomNavigationBar(
        //   backgroundColor: Colors.transparent,
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: secondaryColor,
        //   selectedLabelStyle: const TextStyle(
        //     fontSize: 10,
        //     fontWeight: FontWeight.bold,
        //     letterSpacing: 1,
        //     height: 1.8,
        //     color: orange,
        //   ),
        //   unselectedItemColor: orange.withOpacity(0.4),
        //   elevation: 0,
        //   showSelectedLabels: false,
        //   // iconSize: 20,
        //   showUnselectedLabels: false,
        //   currentIndex: _currentIndex,
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: FaIcon(FontAwesomeIcons.tent),
        //       label: "Beranda",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: FaIcon(FontAwesomeIcons.userClock),
        //       label: "Absensi",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: FaIcon(FontAwesomeIcons.userAstronaut),
        //       label: "Profil",
        //     ),
        //     // BottomNavigationBarItem(
        //     //     icon: Icon(Icons.receipt_long_rounded), label: "Riwayat"),
        //     // BottomNavigationBarItem(
        //     //     icon: Icon(Icons.person_rounded), label: "akun"),
        //   ],
        // ),
        // BottomNavigationBar(
        //   currentIndex: _currentIndex,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profil',
        //     ),
        //   ],
        //   onTap: (index) {
        //     setState(() {
        //       _currentIndex = index;
        //     });
        //   },
        // ),
        // ),

        //////////////////////////////////////////////////// ASLI NYA BEGINI
        // bottomNavigationBar: Container(
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
        //   height: size.width * 0.15,
        //   decoration: BoxDecoration(
        //     color: putih,
        //     borderRadius: BorderRadius.circular(30),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.3),
        //         spreadRadius: 5,
        //         blurRadius: 7,
        //         // offset: const Offset(0, 0),
        //       ),
        //     ],
        //   ),
        //   child: BottomNavigationBar(
        //     backgroundColor: Colors.transparent,
        //     type: BottomNavigationBarType.fixed,
        //     selectedItemColor: secondaryColor,
        //     selectedLabelStyle: const TextStyle(
        //       fontSize: 12,
        //       fontWeight: FontWeight.bold,
        //       letterSpacing: 1,
        //       color: primaryColor,
        //     ),
        //     // unselectedItemColor: secondaryColor,
        //     elevation: 0,
        //     showSelectedLabels: true,
        //     iconSize: 25,
        //     showUnselectedLabels: false,
        //     currentIndex: _currentIndex,
        //     onTap: (index) {
        //       setState(() {
        //         _currentIndex = index;
        //       });
        //     },
        //     items: const [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.grid_view_rounded),
        //         label: "Beranda",
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.list_alt_rounded),
        //         label: "Absensi",
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: "Profil",
        //       ),
        //       // BottomNavigationBarItem(
        //       //     icon: Icon(Icons.receipt_long_rounded), label: "Riwayat"),
        //       // BottomNavigationBarItem(
        //       //     icon: Icon(Icons.person_rounded), label: "akun"),
        //     ],
        //   ),
        //   // BottomNavigationBar(
        //   //   currentIndex: _currentIndex,
        //   //   items: [
        //   //     BottomNavigationBarItem(
        //   //       icon: Icon(Icons.home),
        //   //       label: 'Home',
        //   //     ),
        //   //     BottomNavigationBarItem(
        //   //       icon: Icon(Icons.person),
        //   //       label: 'Profil',
        //   //     ),
        //   //   ],
        //   //   onTap: (index) {
        //   //     setState(() {
        //   //       _currentIndex = index;
        //   //     });
        //   //   },
        //   // ),
      ),
      // ),
    );
  }
}

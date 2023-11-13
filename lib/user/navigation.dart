import 'package:appjmtm/styles.dart';
import 'package:appjmtm/user/Home.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:appjmtm/user/profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Ini akan menutup aplikasi sepenuhnya.
        return false; // false agar tombol kembali tidak melakukan apa pun
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
          height: 65,
          decoration: BoxDecoration(
            color: putih,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                // offset: const Offset(0, 0),
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: secondaryColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: primaryColor,
            ),
            // unselectedItemColor: secondaryColor,
            elevation: 0,
            showSelectedLabels: true,
            iconSize: 26,
            showUnselectedLabels: false,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded),
                label: "Absensi",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profil",
              ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.receipt_long_rounded), label: "Riwayat"),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.person_rounded), label: "akun"),
            ],
          ),
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
        ),
      ),
    );
  }
}

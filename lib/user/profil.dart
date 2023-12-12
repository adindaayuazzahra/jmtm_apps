// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});
  // final String token;
  // Profil({super.key, required this.token});

  // Future<void> logout(BuildContext context) async {
  //   // Hapus token dari SharedPreferences atau tempat penyimpanan token Anda.
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  //   // Navigasi kembali ke halaman login atau halaman awal.
  //   Routes.router
  //       .navigateTo(context, '/login', transition: TransitionType.native);
  // }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor,
      ),
    );
    return Scaffold(
      backgroundColor: putih,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 480,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 270,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(authProvider
                                .user.user.dakar.foto_link.isNotEmpty
                            ? "http://192.168.2.65:8080/fotoUser/${authProvider.user.user.dakar.foto_link}"
                            : 'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
                        // backgroundImage: NetworkImage(
                        //     'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Consumer<AuthProvider>(
                          builder: (context, userProvider, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  // '${authProvider.user.nama}',
                                  // 'lorem aisjcn aoksjcna askmao caoskcm aoiikxmao cqwc cqokc  cqokmc cqokcm qpwkcm cqpkwcm weckwemc cw ec ecw',
                                  '${authProvider.user.user.dakar.nama}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.heebo(
                                    height: 1,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: putih,
                                  ),
                                ),
                                Text(
                                  // '${authProvider.user.jabatan}',
                                  // 'lorem aisjcn aoksjcna askmao caoskcm aoiikxmao cqwc cqokc  cqokmc cqokcm qpwkcm cqpkwcm weckwemc cw ec ecw',
                                  '${authProvider.user.user.dajab.jabatan}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.heebo(
                                    height: 1.1,
                                    fontSize: 14,
                                    color: putih,
                                  ),
                                ),
                                Text(
                                  // '${authProvider.user.npp}',
                                  '${authProvider.user.user.dakar.npp}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.heebo(
                                    height: 1.1,
                                    fontSize: 14,
                                    color: putih,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // INI UNTUK Button
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(10),
                    // height: 120,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(20),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       offset: Offset(0, 10),
                    //       blurRadius: 15,
                    //       color: primaryColor.withOpacity(0.5),
                    //     ),
                    //   ],
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: primaryColor,
                            backgroundColor: orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the border radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.solidIdCard,
                                      color: putih,
                                      size: 40,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Info Karyawan',
                                          style: TextStyle(
                                            color: putih,
                                            // height: 0.8,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Employee Information',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.heebo(
                                              color: putih,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: putih,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: primaryColor,
                            backgroundColor: orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the border radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    // Icon(
                                    //   Icons.work_history_rounded,
                                    //   color: putih,
                                    //   size: 40,
                                    // ),
                                    FaIcon(
                                      FontAwesomeIcons.briefcase,
                                      color: putih,
                                      size: 40,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Jabatan',
                                          style: TextStyle(
                                            color: putih,
                                            // height: 0.8,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'History Jabatan',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.heebo(
                                              color: putih,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: putih,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: primaryColor,
                            backgroundColor: orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the border radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.medal,
                                      color: putih,
                                      size: 40,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Education',
                                          style: TextStyle(
                                            color: putih,
                                            // height: 0.8,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Pelatihan dan Sertifikasi',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.heebo(
                                              color: putih,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                FaIcon(
                                  FontAwesomeIcons.chevronRight,
                                  color: putih,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

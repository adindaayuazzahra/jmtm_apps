// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
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
    // // Dekode token untuk mendapatkan data.
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // String nama = decodedToken['nama'];
    // String npp = decodedToken['npp'];
    // String jabatan = decodedToken['jabatan'];
    return Scaffold(
      backgroundColor: putih,
      appBar: AppBar(
        elevation: 0,
        // shadowColor: Colors.transparent,
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              // padding: EdgeInsets.symmetric(
              //   horizontal: 20,
              // ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35,
                    // backgroundImage: NetworkImage(authProvider
                    //         .user.user.dakar.foto_link.isNotEmpty
                    //     ? "http://192.168.2.126:8080/fotoUser/${authProvider.user.user.dakar.foto_link}"
                    //     : 'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
                    backgroundImage: NetworkImage(
                        'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${authProvider.user.nama}',
                    // '${authProvider.user.user.dakar.nama}',
                    // textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.heebo(
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${authProvider.user.npp} \n${authProvider.user.jabatan}',
                    // '(${authProvider.user.user.dakar.npp}) - ${authProvider.user.user.dajab.jabatan}',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.heebo(
                      height: 1.1,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // INI UNTUK NAMA JABATAN DAN FOTO
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     alignment: Alignment.center,
          //     margin: EdgeInsets.symmetric(horizontal: 20),
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     height: 120,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(20),
          //       boxShadow: [
          //         BoxShadow(
          //           offset: Offset(0, 10),
          //           blurRadius: 15,
          //           color: primaryColor.withOpacity(0.5),
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: <Widget>[
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             CircleAvatar(
          //               radius: 35,
          //               // backgroundImage: NetworkImage(authProvider
          //               //         .user.user.dakar.foto_link.isNotEmpty
          //               //     ? "http://192.168.2.126:8080/fotoUser/${authProvider.user.user.dakar.foto_link}"
          //               //     : 'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
          //               backgroundImage: NetworkImage(
          //                   'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
          //             ),
          //           ],
          //         ),
          //         // const Spacer(),
          //         SizedBox(width: size.width * 0.05),
          //         Consumer<AuthProvider>(
          //           builder: (context, userProvider, child) {
          //             return Expanded(
          //               flex: 1,
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: <Widget>[
          //                   Container(
          //                     width: size.width * 0.54,
          //                     child: Text(
          //                       '${authProvider.user.nama}',
          //                       // '${authProvider.user.user.dakar.nama}',
          //                       // textAlign: TextAlign.center,
          //                       maxLines: 2,
          //                       overflow: TextOverflow.ellipsis,
          //                       style: GoogleFonts.heebo(
          //                         height: 1,
          //                         fontSize: 17,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 5,
          //                   ),
          //                   Container(
          //                     width: size.width * 0.54,
          //                     child: Text(
          //                       '(${authProvider.user.npp}) - ${authProvider.user.jabatan}',
          //                       // '(${authProvider.user.user.dakar.npp}) - ${authProvider.user.user.dajab.jabatan}',
          //                       // textAlign: TextAlign.center,
          //                       maxLines: 2,
          //                       overflow: TextOverflow.ellipsis,
          //                       style: GoogleFonts.heebo(
          //                         height: 1.1,
          //                         fontSize: 13,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Positioned(
      //       top: 0,
      //       left: 0,
      //       right: 0,
      //       child: Container(
      //         alignment: Alignment.center,
      //         padding: EdgeInsets.symmetric(
      //           vertical: 30,
      //         ),
      //         width: double.infinity,
      //         color: secondaryColor,
      //         child: Column(
      //           children: <Widget>[
      //             CircleAvatar(
      //               radius: 35,
      //               // backgroundImage: NetworkImage(authProvider
      //               //         .user.user.dakar.foto_link.isNotEmpty
      //               //     ? "http://192.168.2.126:8080/fotoUser/${authProvider.user.user.dakar.foto_link}"
      //               //     : 'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
      //               backgroundImage: NetworkImage(
      //                   'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               '${authProvider.user.nama}',
      //               // '${authProvider.user.user.dakar.nama}',
      //               // textAlign: TextAlign.center,
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //               style: GoogleFonts.heebo(
      //                 height: 1,
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       top: 100,
      //       left: 20,
      //       right: 20,
      //       child: Container(
      //         alignment: Alignment.center,
      //         padding: EdgeInsets.symmetric(
      //           vertical: 30,
      //         ),
      //         width: double.infinity,
      //         decoration: BoxDecoration(
      //           color: putih,
      //           boxShadow: [
      //             BoxShadow(
      //               offset: Offset(0, 10),
      //               blurRadius: 15,
      //               color: primaryColor.withOpacity(0.5),
      //             ),
      //           ],
      //         ),
      //         child: Column(
      //           children: <Widget>[
      //             CircleAvatar(
      //               radius: 35,
      //               // backgroundImage: NetworkImage(authProvider
      //               //         .user.user.dakar.foto_link.isNotEmpty
      //               //     ? "http://192.168.2.126:8080/fotoUser/${authProvider.user.user.dakar.foto_link}"
      //               //     : 'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
      //               backgroundImage: NetworkImage(
      //                   'https://www.copaster.com/wp-content/uploads/2023/03/pp-kosong-wa-default.jpeg'),
      //             ),
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               '${authProvider.user.nama}',
      //               // '${authProvider.user.user.dakar.nama}',
      //               // textAlign: TextAlign.center,
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //               style: GoogleFonts.heebo(
      //                 height: 1,
      //                 fontSize: 17,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

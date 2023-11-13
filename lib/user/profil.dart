// ignore_for_file: use_build_context_synchronously

import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
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
    // // Dekode token untuk mendapatkan data.
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // String nama = decodedToken['nama'];
    // String npp = decodedToken['npp'];
    // String jabatan = decodedToken['jabatan'];
    return Scaffold(
      backgroundColor: putih,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('PROFILLLLLLLLLLLLLLLLLL'),
            Text('HALO'),
            Text('Nama: ${authProvider.user.nama}'),
            Text('NPP: ${authProvider.user.npp}'),
            Text('Jabatan: ${authProvider.user.jabatan}'),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                  ),
                ),
                onPressed: () async {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  await authProvider.logout();

                  Routes.router.navigateTo(context, '/login',
                      transition: TransitionType.inFromRight, replace: true);
                },
                child: Text("Logout".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
              ),
            ),
            // Tampilkan data lainnya jika  .
          ],
        ),
      ),
    );
  }
}

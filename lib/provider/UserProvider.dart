// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:appjmtm/Config/config.dart';
import 'package:appjmtm/common/routes.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/model/User.dart';
import 'package:appjmtm/user/navigation.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  late User _user = User(
    user: UserClass(
      dajab: Dajab(
        tgl_sk: '',
        tgl_akhir_sk: '',
        nomor_sk: '',
        jabatan: '',
        direktorat: '',
        departemen: '',
        seksi: '',
        grade: '',
        lampiran: '',
      ),
      dakar: Dakar(
        npp: '',
        nama: '',
        id: 0,
        statusPegawai: '',
        jenisKelamin: '',
        pendidikan: '',
        tglMasuk: '',
        tglLahir: '',
        tempatLahir: '',
        agama: '',
        rw: '',
        asalPenugasan: '',
        kota: '',
        alamat: '',
        ktp: '',
        alamatKtp: '',
        kelurahan: '',
        kecamatan: '',
        provinsi: '',
        statusDiri: '',
        npwp: '',
        bpjsKesehatan: '',
        bpjsTk: '',
        fotoLink: '',
        kdComp: '',
        telpon: '',
        email: '',
        tglKeluar: '',
        golDarah: '',
        alasanKeluar: '',
        emailKantor: '',
        password: '',
      ),
      status_akses: '',
      id_role: 0,
      id_master_akses: 0,
      hisjab: [],
      status_absen: 0,
    ),
  );

  // static String? _token;

  late String _token;

  String? get token => _token;

  bool get isAuthenticated => _user.user.dakar.npp.isNotEmpty;

  User get user => _user;

  final apiUrl = AppConfig.apiUrl;

  Future<void> login(BuildContext context, TextEditingController nppController,
      TextEditingController passwordController) async {
    Size size = MediaQuery.of(context).size;
    if (nppController.text == '' || passwordController.text == '') {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon:
                Image.asset("assets/images/gagal.gif", width: size.width * 0.2),
            surfaceTintColor: putih,
            backgroundColor: putih,
            title: Text(
              'Login Gagal'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Password atau Username Tidak Boleh Kosong!'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 16),
            ),
            actions: [
              TextButton(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tutup'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: putih,
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final response = await http.post(
      Uri.parse('${apiUrl}login'),
      body: {
        'username_admin': nppController.text,
        'password_admin': passwordController.text,
        'validate': 'ANAKKAMPRETMAULEWAT',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print(responseData['token']);
      if (responseData['status'] == 1) {
        final Map<String, dynamic> userData =
            JwtDecoder.decode(responseData['token']);
        // final Map<String, dynamic> userData2 = userData['user'];
        // print(userData);
        _user = User.fromJson(userData);
        _token = responseData['token'];
        // _token = responseData['token'];
        // MENYIMPAN DATA sUSER DI SHARED PREFERENCES
        await _saveUserDataToPrefs();
        notifyListeners();
        // if (passwordController.text == 'Welcomejmtm!') {
        //   // Jika password adalah password default, navigasikan ke halaman home dan tampilkan alert
        //   await Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => Home()),
        //   ).then((_) {
        //     // Tampilkan alert setelah navigasi selesai
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: Text('Ganti Password'),
        //           content:
        //               Text('Harap ganti password default Anda untuk keamanan.'),
        //           actions: [
        //             TextButton(
        //               child: Text('OK'),
        //               onPressed: () {
        //                 Navigator.of(context).pop();
        //               },
        //             ),
        //           ],
        //         );
        //       },
        //     );
        //   });
        // } else {
        //   Routes.router.navigateTo(
        //     context,
        //     '/navigation',
        //     transition: TransitionType.inFromRight,
        //   );
        // }

        if (passwordController.text == 'Welcomejmtm!') {
          // Navigasi ke halaman home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Navigation()),
          );

          // Tampilkan alert setelah navigasi selesai
          Future.microtask(() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon: Image.asset("assets/images/gantipassword.gif",
                      width: size.width * 0.2),
                  surfaceTintColor: putih,
                  backgroundColor: putih,
                  title: Text(
                    'Ganti Password'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                    'Harap ganti password default Anda untuk keamanan.'
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        height: 1.2,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          });
        } else {
          // Navigasi ke halaman utama tanpa alert
          Routes.router.navigateTo(
            context,
            '/navigation',
            transition: TransitionType.inFromRight,
          );
        }
      } else if (responseData['status'] == 0) {
        // throw Exception('Token is null in response');
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: Image.asset("assets/images/gagal.gif",
                  width: size.width * 0.2),
              surfaceTintColor: putih,
              backgroundColor: putih,
              title: Text(
                'Login Gagal'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                responseData['error_message'].toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16),
              ),
              actions: [
                TextButton(
                  child: Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tutup'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: putih,
                          ),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      throw Exception(
          'Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
    }
  }

  Future<void> logout() async {
    // Hapus data user dari Shared Preferences
    await _removeUserDataFromPrefs();
    _token = '';
    _user = User(
      user: UserClass(
        dajab: Dajab(
          tgl_sk: '',
          tgl_akhir_sk: '',
          nomor_sk: '',
          jabatan: '',
          direktorat: '',
          departemen: '',
          seksi: '',
          grade: '',
          lampiran: '',
        ),
        dakar: Dakar(
          npp: '',
          nama: '',
          id: 0,
          statusPegawai: '',
          jenisKelamin: '',
          pendidikan: '',
          tglMasuk: '',
          tglLahir: '',
          tempatLahir: '',
          agama: '',
          rw: '',
          asalPenugasan: '',
          kota: '',
          alamat: '',
          ktp: '',
          alamatKtp: '',
          kelurahan: '',
          kecamatan: '',
          provinsi: '',
          statusDiri: '',
          npwp: '',
          bpjsKesehatan: '',
          bpjsTk: '',
          fotoLink: '',
          kdComp: '',
          telpon: '',
          email: '',
          tglKeluar: '',
          golDarah: '',
          alasanKeluar: '',
          emailKantor: '',
          password: '',
        ),
        status_akses: '',
        id_role: 0,
        id_master_akses: 0,
        hisjab: [],
        status_absen: 0,
      ),
    );
    // absenProvider?.resetDataAbsen();
    notifyListeners();
  }

  Future<void> _saveUserDataToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', json.encode(_user.toJson()));
    prefs.setString('tokenStr', _token);
  }

  Future<void> _removeUserDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.remove('tokenStr');
  }

  Future<void> autoLogin() async {
    // print('Auto login triggered');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final userData = json.decode(prefs.getString('userData')!);
      // print('User data from SharedPreferences: $userData');
      final String? token = prefs.getString('tokenStr');
      // _token = token!;
      if (token != null) {
        _token = token;
        _user = User.fromJson(userData);
        notifyListeners();
      } else {
        // Handle case when token is null
        // Misalnya, lakukan logout atau tindakan lain yang sesuai
      }
      _user = User.fromJson(userData);
      notifyListeners();
      // print('Authentication status after autoLogin: ${isAuthenticated}');
    }
  }

  // Future<void> gantiPassword(
  //     TextEditingController passold,
  //     TextEditingController passnew,
  //     TextEditingController konfirmasi,
  //     String npp) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${apiUrl}ganti_password'),
  //       body: {
  //         'npp': npp.text,
  //         'pass_old': passold.text,
  //         'pass_new': passnew.text,
  //         'pass_confirm': konfirmasi.text,
  //         'validate': 'ANAKKAMPRETMAULEWAT',
  //       },
  //     );
  //     // print('${apiUrl}ganti_password');
  //     if (response.statusCode == 200) {
  //       // ini pengen feedback shwodialaog ke halaman ganti password
  //     } else {
  //       //nampilin showdialog feedbeck gagal
  //     }
  //   } catch (e) {
  //     print('Error during login: $e');
  //     print('User Data: $_user');
  //     throw Exception('Failed to login: $e');
  //   }
  // }
}

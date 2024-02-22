// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:appjmtm/Config/config.dart';
import 'package:appjmtm/model/User.dart';
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
        status_pegawai: '',
        foto_link: '',
        kd_comp: '',
      ),
      status_akses: '',
      id_role: 0,
      id_master_akses: 0,
      hisjab: [],
      status_absen: 0,
    ),
  );
  bool get isAuthenticated => _user.user.dakar.npp.isNotEmpty;

  User get user => _user;

  final apiUrl = AppConfig.apiUrl;

  Future<void> login(TextEditingController nppController,
      TextEditingController passwordController) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}login'),
        body: {
          'username_admin': nppController.text,
          'password_admin': passwordController.text,
          'validate': 'ANAKKAMPRETMAULEWAT',
        },
      );
      print('${apiUrl}login');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];
        if (token != null) {
          final Map<String, dynamic> userData = JwtDecoder.decode(token);
          // final Map<String, dynamic> userData2 = userData['user'];
          // print(userData);
          _user = User.fromJson(userData);

          // MENYIMPAN DATA USER DI SHARED PREFERENCES
          await _saveUserDataToPrefs();
          print(_user.user.dakar.foto_link);
          notifyListeners();
        } else {
          throw Exception('Token is null in response');
        }
      } else {
        throw Exception(
            'Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error during login: $e');
      print('User Data: $_user');
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    // Hapus data user dari Shared Preferences
    await _removeUserDataFromPrefs();
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
          status_pegawai: '',
          foto_link: '',
          kd_comp: '',
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
  }

  Future<void> _removeUserDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  Future<void> autoLogin() async {
    // print('Auto login triggered');
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final userData = json.decode(prefs.getString('userData')!);
      // print('User data from SharedPreferences: $userData');
      _user = User.fromJson(userData);
      notifyListeners();
      // print('Authentication status after autoLogin: ${isAuthenticated}');
    }
  }
}

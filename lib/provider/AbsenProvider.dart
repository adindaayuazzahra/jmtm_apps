// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:appjmtm/Config/config.dart';
import 'package:appjmtm/model/Absen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AbsenProvider extends ChangeNotifier {
  late AbsenData _absenData = AbsenData(absen: [
    Absen(
        npp: '',
        latitude: '',
        longitude: '',
        masuk: '',
        keluar: '',
        status: '',
        createdAt: '',
        fotoLink: '',
        alamat: '')
  ], imgRouteAbsen: '');

  AbsenData get absenData => _absenData;

  void resetDataAbsen() {
    _absenData.absen.clear();
    notifyListeners();
  }

  final apiUrl = AppConfig.apiUrl;

  Future<void> fetchDataAbsen(npp, tanggal) async {
    //  final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}cek_absensi'),
        body: {
          'npp': npp,
          'tanggal': tanggal,
          'validate': 'ANAKKAMPRETMAULEWAT',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];
        if (token != null) {
          final Map<String, dynamic> userData = JwtDecoder.decode(token);
          final Map<String, dynamic> userData2 = userData['user'];
          _absenData = AbsenData.fromJson(userData2);
          notifyListeners();
        } else {
          throw Exception('Token is null in response');
        }
      } else {
        throw Exception(
            'Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error during fetch data: $e');
      print('User Data: $_absenData');
      throw Exception('Failed to fetch data: $e');
    }
  }
}

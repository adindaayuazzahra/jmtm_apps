import 'package:appjmtm/config/config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:appjmtm/model/Absen.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class HistoryAbsenProvider extends ChangeNotifier {
  late AbsenData _absenHis = AbsenData(absen: [
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
  AbsenData get absenHis => _absenHis;
  void resethis() {
    // _absenData.absen.clear();
    _absenHis.absen.clear();
    notifyListeners();
  }

  final apiUrl = AppConfig.apiUrl;

  Future<void> history(npp, tanggal) async {
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
        // print(token);
        if (token.isNotEmpty) {
          final Map<String, dynamic> userData = JwtDecoder.decode(token);
          // print(userData);
          final Map<String, dynamic> userData2 = userData['user'];
          _absenHis = AbsenData.fromJson(userData2);
          // print('Absen Data:');
          // for (var absen in _absenHis.absen) {
          //   print('NPP: ${absen.npp}');
          //   print('Latitude: ${absen.latitude}');
          //   print('Longitude: ${absen.longitude}');
          //   print('Masuk: ${absen.masuk}');
          //   print('Keluar: ${absen.keluar}');
          //   print('Status: ${absen.status}');
          //   print('CreatedAt: ${absen.createdAt}');
          //   print('Foto Link: ${absen.fotoLink}');
          //   print('Alamat: ${absen.alamat}');
          //   print('----------------------');
          // }
          notifyListeners();
        } else {
          throw Exception('Token is null in response');
        }
      } else {
        throw Exception(
            'Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      // print('Error during fetch data: $e');
      // print('User Data: $_absenHis');
      throw Exception('Failed to fetch data: $e');
    }
  }
}

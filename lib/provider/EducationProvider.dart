import 'package:appjmtm/model/Pelatihan.dart';
import 'package:appjmtm/model/Pendidikan.dart';
import 'package:flutter/material.dart';
import 'package:appjmtm/config/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

class EducationProvider extends ChangeNotifier {
  late Pendidikan _pendidikan = Pendidikan(pendidikan: [
    DetailPendidikan(
        id: 0,
        tingkatPendidikan: '',
        jurusan: '',
        lampiran: '',
        namaLembaga: '',
        npp: '',
        tahunLulus: '',
        kriteria: '',
        gelar: '',
        kdWilayah: '',
        negara: '',
        linkDoc: '')
  ]);

  Pendidikan get pendidikan => _pendidikan;

  late Pelatihan _pelatihan = Pelatihan(pelatihan: [
    DetailPelatihan(
      id: 0,
      npp: '',
      nmPelatihan: '',
      typePelatihan: '',
      tanggalPelatihan: '',
      kategoriPelatihan: '',
      sertifikasiKeahlian: '',
      tglAwal: '',
      tglAkhir: '',
      pelaksana: '',
      learningAcademy: '',
      inisiator: '',
      lampiran: '',
      status: '',
      idPelatihan: 0,
    )
  ]);
  Pelatihan get pelatihan => _pelatihan;

  void resethis() {
    // _Pendidikan.absen.clear();
    _pendidikan.pendidikan.clear();
    _pelatihan.pelatihan.clear();
    notifyListeners();
  }

  final apiUrl = AppConfig.apiUrl;

  bool _hasError = false;
  String _errorMessage = '';
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> fetchPendidikan(npp) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}info_pendidikan'),
        body: {
          'npp': npp,
          // 'tanggal': tanggal,
          'validate': 'ANAKKAMPRETMAULEWAT',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];
        if (token.isNotEmpty) {
          final Map<String, dynamic> userData = JwtDecoder.decode(token);
          final Map<String, dynamic> userData2 = userData['user'];
          // print(userData2);
          _pendidikan = Pendidikan.fromJson(userData2);
          // print('Data pendidikan:');
          // for (var p in _pendidikan.pendidikan) {
          //   print('NPP: ${p.npp}');
          //   print('tahun lulus: ${p.tahunLulus}');
          //   print('link doc: ${p.linkDoc}');
          //   print('----------------------');
          // }
          notifyListeners();
        } else {
          throw Exception('Token is null in response');
        }
      }
      // else {
      //   // throw Exception(
      //   //     'Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
      //   _hasError = true;
      //   _errorMessage = 'Failed to load data';
      //   print(_hasError);
      // }
    } catch (e) {
      _hasError = true;
      _errorMessage = 'Gagal memuat Data. Kesalahan Server';
      // print(_hasError);
    }
    notifyListeners();
  }

  Future<void> fetchPelatihan(npp) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}info_pelatihan'),
        body: {
          'npp': npp,
          // 'tanggal': tanggal,
          'validate': 'ANAKKAMPRETMAULEWAT',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];
        if (token.isNotEmpty) {
          final Map<String, dynamic> userData = JwtDecoder.decode(token);
          final Map<String, dynamic> userData2 = userData['user'];
          // print(userData2);
          _pelatihan = Pelatihan.fromJson(userData2);
          // print('Absen Data:');
          // `for (var p in _pelatihan.pelatihan) {
          //   print('NPP: ${p.npp}');
          //   print('nama pelatihan: ${p.nmPelatihan}');
          //   print('tanggal pelatihan: ${p.tanggalPelatihan}');
          //   print('pelaksana: ${p.pelaksana}');
          //   print('lampiran: ${p.lampiran}');
          //   print('inisiator: ${p.inisiator}');
          //   print('----------------------');
          // }`
          notifyListeners();
        } else {
          throw Exception('Token is null in response');
        }
      } else {
        throw Exception(
            'Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}

import 'package:intl/intl.dart';

class AbsenData {
  List<Absen> absen;
  String imgRouteAbsen;

  AbsenData({
    required this.absen,
    required this.imgRouteAbsen,
  });

  factory AbsenData.fromJson(Map<String, dynamic> json) {
    return AbsenData(
      absen: (json['absen'] as List)
          .map((absenJson) => Absen.fromJson(absenJson))
          .toList(),
      imgRouteAbsen: json['img_route_absen'] ?? '',
    );
  }
}

class Absen {
  String npp;
  String latitude;
  String longitude;
  String masuk;
  String keluar;
  String status;
  String createdAt;
  String fotoLink;
  String alamat;

  Absen({
    required this.npp,
    required this.latitude,
    required this.longitude,
    required this.masuk,
    required this.keluar,
    required this.status,
    required this.createdAt,
    required this.fotoLink,
    required this.alamat,
  });

  factory Absen.fromJson(Map<String, dynamic> json) {
    return Absen(
      npp: json['npp'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longtitude'] ?? '',
      masuk: json['masuk'] ?? '',
      keluar: json['keluar'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      fotoLink: json['foto_link'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }
}

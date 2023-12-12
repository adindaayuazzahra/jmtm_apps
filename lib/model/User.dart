// ignore_for_file: non_constant_identifier_names

// class User {
//   // final String token;
//   final String npp;
//   final String nama;
//   final String jabatan;
//   // final String password;

//   User({
//     // required this.token,
//     required this.npp,
//     required this.nama,
//     required this.jabatan,
//     // required this.password,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         // token: json['token'],
//         npp: json['npp'],
//         nama: json['nama'],
//         // password: json['password'],
//         jabatan: json['jabatan']);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'npp': npp,
//       'nama': nama,
//       'jabatan': jabatan,
//     };
//   }
// }

class User {
  UserClass user;

  User({
    required this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user: UserClass.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
    };
  }
}

class UserClass {
  Dakar dakar;
  Dajab dajab;
  String status_akses;
  int id_role;
  int id_master_akses;

  UserClass({
    required this.dakar,
    required this.dajab,
    required this.status_akses,
    required this.id_role,
    required this.id_master_akses,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      dakar: Dakar.fromJson(json['dakar'] ?? {}),
      dajab: Dajab.fromJson(json['dajab'] ?? {}),
      status_akses: json['status_akses'] ?? '',
      id_role: json['id_role'] ?? 0,
      id_master_akses: json['id_master_akses'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dakar': dakar.toJson(),
      'dajab': dajab.toJson(),
      'status_akses': status_akses,
      'id_role': id_role,
      'id_master_akses': id_master_akses,
    };
  }
}

class Dajab {
  String tgl_sk;
  String tgl_akhir_sk;
  String nomor_sk;
  String jabatan;
  String direktorat;
  String departemen;
  String seksi;
  String grade;

  Dajab({
    required this.tgl_sk,
    required this.tgl_akhir_sk,
    required this.nomor_sk,
    required this.jabatan,
    required this.direktorat,
    required this.departemen,
    required this.seksi,
    required this.grade,
  });

  factory Dajab.fromJson(Map<String, dynamic> json) {
    return Dajab(
      tgl_sk: json['tgl_sk'] ?? '',
      tgl_akhir_sk: json['tgl_akhir_sk'] ?? '',
      nomor_sk: json['nomor_sk'] ?? '',
      jabatan: json['jabatan'] ?? '',
      direktorat: json['direktorat'] ?? '',
      departemen: json['departemen'] ?? '',
      seksi: json['seksi'] ?? '',
      grade: json['grade'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tgl_sk': tgl_sk,
      'tgl_akhir_sk': tgl_akhir_sk,
      'nomor_sk': nomor_sk,
      'jabatan': jabatan,
      'direktorat': direktorat,
      'departemen': departemen,
      'seksi': seksi,
      'grade': grade,
    };
  }
}

class Dakar {
  int id;
  String nama;
  String npp;
  String kd_comp;
  String status_pegawai;
  String foto_link;

  Dakar({
    required this.id,
    required this.nama,
    required this.npp,
    required this.kd_comp,
    required this.status_pegawai,
    required this.foto_link,
  });

  factory Dakar.fromJson(Map<String, dynamic> json) {
    return Dakar(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      npp: json['npp'] ?? '',
      kd_comp: json['kd_comp'] ?? '',
      status_pegawai: json['status_pegawai'] ?? '',
      foto_link: json['foto_link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'npp': npp,
      'kd_comp': kd_comp,
      'status_pegawai': status_pegawai,
      'foto_link': foto_link,
    };
  }
}

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
  List<Hisjab> hisjab;
  String status_akses;
  int status_absen;
  int id_role;
  int id_master_akses;

  UserClass({
    required this.hisjab,
    required this.dakar,
    required this.dajab,
    required this.status_akses,
    required this.status_absen,
    required this.id_role,
    required this.id_master_akses,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      dakar: Dakar.fromJson(json['dakar'] ?? {}),
      dajab: Dajab.fromJson(json['dajab'] ?? {}),
      status_akses: json['status_akses'] ?? '',
      status_absen: json['status_absen'] ?? 0,
      id_role: json['id_role'] ?? 0,
      id_master_akses: json['id_master_akses'] ?? 0,
      hisjab: _parseHisjab(json['hisjab'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dakar': dakar.toJson(),
      'dajab': dajab.toJson(),
      'status_akses': status_akses,
      'status_absen': status_absen,
      'id_role': id_role,
      'id_master_akses': id_master_akses,
      'hisjab': _hisjabListToJson(),
    };
  }

  static List<Hisjab> _parseHisjab(List<dynamic> jsonList) {
    return jsonList.map((json) => Hisjab.fromJson(json)).toList();
  }

  List<Map<String, dynamic>> _hisjabListToJson() {
    return hisjab.map((hisjabData) => hisjabData.toJson()).toList();
  }
}

class Hisjab {
  int id;
  String id_jabatan;
  String npp;
  String kd_comp;
  String tgl_sk;
  String tgl_akhir_sk;
  String nomor_sk;
  String keterangan;
  String lampiran;
  String status_aktif;
  String jabatan;
  String id_atasan;
  String direktorat;
  String departemen;
  String seksi;
  String grade;
  String status;
  String npp_atasan;
  String nama_atasan;
  String jabatan_atasan;

  Hisjab({
    required this.id,
    required this.id_jabatan,
    required this.npp,
    required this.kd_comp,
    required this.tgl_sk,
    required this.tgl_akhir_sk,
    required this.nomor_sk,
    required this.keterangan,
    required this.lampiran,
    required this.status_aktif,
    required this.jabatan,
    required this.id_atasan,
    required this.direktorat,
    required this.departemen,
    required this.seksi,
    required this.grade,
    required this.status,
    required this.npp_atasan,
    required this.nama_atasan,
    required this.jabatan_atasan,
  });

  factory Hisjab.fromJson(Map<String, dynamic> json) {
    return Hisjab(
      id: json['id'] ?? 0,
      id_jabatan: json['id_jabatan'] ?? '',
      npp: json['npp'] ?? '',
      kd_comp: json['kd_comp'] ?? '',
      tgl_sk: json['tgl_sk'] ?? '',
      tgl_akhir_sk: json['tgl_akhir_sk'] ?? '',
      nomor_sk: json['nomor_sk'] ?? '',
      keterangan: json['keterangan'] ?? '',
      lampiran: json['lampiran'] ?? '',
      status_aktif: json['status_aktif'] ?? '',
      jabatan: json['jabatan'] ?? '',
      id_atasan: json['id_atasan'] ?? '',
      direktorat: json['direktorat'] ?? '',
      departemen: json['departemen'] ?? '',
      seksi: json['seksi'] ?? '',
      grade: json['grade'] ?? '',
      status: json['status'] ?? '',
      npp_atasan: json['npp_atasan'] ?? '',
      nama_atasan: json['nama_atasan'] ?? '',
      jabatan_atasan: json['jabatan_atasan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_jabatan': id_jabatan,
      'npp': npp,
      'kd_comp': kd_comp,
      'tgl_sk': tgl_sk,
      'tgl_akhir_sk': tgl_akhir_sk,
      'nomor_sk': nomor_sk,
      'keterangan': keterangan,
      'lampiran': lampiran,
      'status_aktif': status_aktif,
      'jabatan': jabatan,
      'id_atasan': id_atasan,
      'direktorat': direktorat,
      'departemen': departemen,
      'seksi': seksi,
      'grade': grade,
      'status': status,
      'npp_atasan': npp_atasan,
      'nama_atasan': nama_atasan,
      'jabatan_atasan': jabatan_atasan,
    };
  }
}

class Dajab {
  String tgl_sk;
  String tgl_akhir_sk;
  String nomor_sk;
  String lampiran;
  String jabatan;
  String direktorat;
  String departemen;
  String seksi;
  String grade;

  Dajab({
    required this.tgl_sk,
    required this.tgl_akhir_sk,
    required this.nomor_sk,
    required this.lampiran,
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
      lampiran: json['lampiran'] ?? '',
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
      'lampiran': lampiran,
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
  String npp;
  String nama;
  String statusPegawai;
  String jenisKelamin;
  String tempatLahir;
  String tglLahir;
  String agama;
  String tglMasuk;
  String pendidikan;
  String ktp;
  String alamat;
  String alamatKtp;
  String asalPenugasan;
  String rw;
  String kelurahan;
  String kecamatan;
  String kota;
  String provinsi;
  String npwp;
  String statusDiri;
  String kdComp;

  String bpjsTk;
  String bpjsKesehatan;
  String telpon;
  String email;
  String fotoLink;
  String alasanKeluar;
  String tglKeluar;
  String emailKantor;
  String golDarah;
  String password;

  Dakar({
    required this.id,
    required this.npp,
    required this.nama,
    required this.statusPegawai,
    required this.jenisKelamin,
    required this.tempatLahir,
    required this.tglLahir,
    required this.agama,
    required this.tglMasuk,
    required this.pendidikan,
    required this.ktp,
    required this.alamat,
    required this.alamatKtp,
    required this.asalPenugasan,
    required this.rw,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.npwp,
    required this.statusDiri,
    required this.kdComp,
    required this.bpjsTk,
    required this.bpjsKesehatan,
    required this.telpon,
    required this.email,
    required this.fotoLink,
    required this.alasanKeluar,
    required this.tglKeluar,
    required this.emailKantor,
    required this.golDarah,
    required this.password,
  });

  factory Dakar.fromJson(Map<String, dynamic> json) {
    return Dakar(
      id: json['id'] ?? 0,
      npp: json["npp"] ?? "",
      nama: json["nama"] ?? "",
      statusPegawai: json["status_pegawai"] ?? "",
      jenisKelamin: json["jenis_kelamin"] ?? "",
      tempatLahir: json["tempat_lahir"] ?? "",
      tglLahir: json["tgl_lahir"] ?? "",
      agama: json["agama"] ?? "",
      tglMasuk: json["tgl_masuk"] ?? "",
      pendidikan: json["pendidikan"] ?? "",
      ktp: json["KTP"] ?? "",
      alamat: json["alamat"] ?? "",
      alamatKtp: json["alamat_ktp"] ?? "",
      asalPenugasan: json["asal_penugasan"] ?? "",
      rw: json["rw"] ?? "",
      kelurahan: json["kelurahan"] ?? "",
      kecamatan: json["kecamatan"] ?? "",
      kota: json["kota"] ?? "",
      provinsi: json["provinsi"] ?? "",
      npwp: json["npwp"] ?? "",
      statusDiri: json["status_diri"] ?? "",
      kdComp: json["kd_comp"] ?? "",
      bpjsTk: json["bpjs_tk"] ?? "",
      bpjsKesehatan: json["bpjs_kesehatan"] ?? "",
      telpon: json["telpon"] ?? "",
      email: json["email"] ?? "",
      fotoLink: json["foto_link"] ?? "",
      alasanKeluar: json["alasan_keluar"] ?? "",
      tglKeluar: json["tgl_keluar"] ?? "",
      emailKantor: json["email_kantor"] ?? "",
      golDarah: json["gol_darah"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "npp": npp,
      "nama": nama,
      "status_pegawai": statusPegawai,
      "jenis_kelamin": jenisKelamin,
      "tempat_lahir": tempatLahir,
      "tgl_lahir": tglLahir,
      "agama": agama,
      "tgl_masuk": tglMasuk,
      "pendidikan": pendidikan,
      "KTP": ktp,
      "alamat": alamat,
      "alamat_ktp": alamatKtp,
      "asal_penugasan": asalPenugasan,
      "rw": rw,
      "kelurahan": kelurahan,
      "kecamatan": kecamatan,
      "kota": kota,
      "provinsi": provinsi,
      "npwp": npwp,
      "status_diri": statusDiri,
      "kd_comp": kdComp,
      "bpjs_tk": bpjsTk,
      "bpjs_kesehatan": bpjsKesehatan,
      "telpon": telpon,
      "email": email,
      "foto_link": fotoLink,
      "alasan_keluar": alasanKeluar,
      "tgl_keluar": tglKeluar,
      "email_kantor": emailKantor,
      "gol_darah": golDarah,
      "password": password,
    };
  }
}

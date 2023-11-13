/*class User {
  final String token;
  final String npp;
  final String nama;
  final String password;
  final Identitas identitas;

  User(
      {required this.token,
      required this.npp,
      required this.nama,
      required this.password,
      required this.identitas});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      npp: json['npp'],
      nama: json['nama'],
      password: json['password'],
      identitas: Identitas.fromJson(json['identitas']),
    );
  }
}

class Identitas {
  final String nik;
  final String kk;
  final String tp;

  Identitas({required this.nik, required this.kk, required this.tp});

  factory Identitas.fromJson(Map<String, dynamic> json) {
    return Identitas(
      nik: json['nik'],
      kk: json['kk'],
      tp: json['tp'],
    );
  }
}*/

class User {
  // final String token;
  final String npp;
  final String nama;
  final String jabatan;
  // final String password;

  User({
    // required this.token,
    required this.npp,
    required this.nama,
    required this.jabatan,
    // required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        // token: json['token'],
        npp: json['npp'],
        nama: json['nama'],
        // password: json['password'],
        jabatan: json['jabatan']);
  }

  Map<String, dynamic> toJson() {
    return {
      'npp': npp,
      'nama': nama,
      'jabatan': jabatan,
    };
  }
}

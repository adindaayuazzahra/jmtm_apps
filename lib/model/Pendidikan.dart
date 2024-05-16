class Pendidikan {
  List<DetailPendidikan> pendidikan;

  Pendidikan({
    required this.pendidikan,
  });

  factory Pendidikan.fromJson(Map<String, dynamic> json) {
    return Pendidikan(
      pendidikan: (json['pendidikan'] as List)
          .map((pendidikanJson) => DetailPendidikan.fromJson(pendidikanJson))
          .toList(),
    );
  }
}

class DetailPendidikan {
  int id;
  String npp;
  String tingkatPendidikan;
  String namaLembaga;
  String jurusan;
  String tahunLulus;
  String gelar;
  String lampiran;
  String kriteria;
  String kdWilayah;
  String negara;
  String linkDoc;

  DetailPendidikan({
    required this.id,
    required this.npp,
    required this.tingkatPendidikan,
    required this.namaLembaga,
    required this.jurusan,
    required this.tahunLulus,
    required this.gelar,
    required this.lampiran,
    required this.kriteria,
    required this.kdWilayah,
    required this.negara,
    required this.linkDoc,
  });

  factory DetailPendidikan.fromJson(Map<String, dynamic> json) {
    return DetailPendidikan(
      id: json['id'] ?? 0,
      npp: json['npp'] ?? '',
      tingkatPendidikan: json['tingkat_pendidikan'] ?? '',
      namaLembaga: json['nama_lembaga'] ?? '',
      jurusan: json['jurusan'] ?? '',
      tahunLulus: json['tahun_lulus'] ?? '',
      gelar: json['gelar'] ?? '',
      kriteria: json['kriteria'] ?? '',
      kdWilayah: json['kd_wilayah'] ?? '',
      negara: json['negara'] ?? '',
      linkDoc: json['link_doc'] ?? '',
      lampiran: json['lampiran'] ?? '',
    );
  }
}

class Pelatihan {
  List<DetailPelatihan> pelatihan;

  Pelatihan({
    required this.pelatihan,
  });

  factory Pelatihan.fromJson(Map<String, dynamic> json) {
    return Pelatihan(
      pelatihan: (json['pelatihan'] as List)
          .map((pelatihanJson) => DetailPelatihan.fromJson(pelatihanJson))
          .toList(),
    );
  }
}

class DetailPelatihan {
  int id;
  String npp;
  String nmPelatihan;
  String typePelatihan;
  String tanggalPelatihan;
  String kategoriPelatihan;
  String sertifikasiKeahlian;
  String tglAwal;
  String tglAkhir;
  String pelaksana;
  String learningAcademy;
  String inisiator;
  String lampiran;
  String status;
  int idPelatihan;

  DetailPelatihan({
    required this.id,
    required this.npp,
    required this.nmPelatihan,
    required this.typePelatihan,
    required this.tanggalPelatihan,
    required this.kategoriPelatihan,
    required this.sertifikasiKeahlian,
    required this.tglAwal,
    required this.tglAkhir,
    required this.pelaksana,
    required this.learningAcademy,
    required this.inisiator,
    required this.lampiran,
    required this.status,
    required this.idPelatihan,
  });

  factory DetailPelatihan.fromJson(Map<String, dynamic> json) {
    return DetailPelatihan(
      id: json['id'] ?? 0,
      npp: json['npp'] ?? '',
      nmPelatihan: json['nm_pelatihan'] ?? '',
      typePelatihan: json['type_pelatihan'] ?? '',
      tanggalPelatihan: json['tanggal_pelatihan'] ?? '',
      kategoriPelatihan: json['kategori_pelatihan'] ?? '',
      sertifikasiKeahlian: json['sertifikasi_keahlian'] ?? '',
      tglAwal: json['tgl_awal'] ?? '',
      tglAkhir: json['tgl_akhir'] ?? '',
      pelaksana: json['pelaksana'] ?? '',
      learningAcademy: json['learning_academy'] ?? '',
      status: json['status'] ?? '',
      inisiator: json['inisiator'] ?? '',
      lampiran: json['lampiran'] ?? '',
      idPelatihan: json['id_pelatihan'] ?? 0,
    );
  }
}

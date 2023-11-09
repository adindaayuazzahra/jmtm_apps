class Berita {
  final String title;
  final String image;
  final String date;
  final String link;
  final String id;

  Berita({
    required this.title,
    required this.image,
    required this.date,
    required this.link,
    required this.id,
  });
}

class DetailBerita {
  final String title;
  final String image;
  final String date;
  final String desc;
  final String id;

  DetailBerita({
    required this.title,
    required this.image,
    required this.date,
    required this.desc,
    required this.id,
  });
}

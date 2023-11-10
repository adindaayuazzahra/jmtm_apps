// import 'package:appjmtm/model/DetailBerita.dart';
import 'package:appjmtm/model/berita.dart';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier {
  List<Berita> _newsList = [];

  List<Berita> get newsList => _newsList;

  List<DetailBerita> _detailberita = [];

  List<DetailBerita> get detailBerita => _detailberita;

  // Fungsi untuk mengambil data berita dari sumber eksternal
  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('https://jmtm.co.id/berita'));

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final newsList = <Berita>[];

        final articleElements = document.querySelectorAll('div.card');
        for (var article in articleElements) {
          final articleTitle = article.querySelector('.card-title')?.text;
          final articleDate = article.querySelector('.text-muted')?.text;
          final articleImage =
              article.querySelector('img')?.attributes['src'] ?? '';
          final articleLink =
              article.querySelector('a')?.attributes['href'] ?? '';

          if (articleTitle != null && articleDate != null) {
            newsList.add(Berita(
              title: articleTitle,
              date: articleDate,
              image: articleImage,
              link: articleLink,
              id: articleLink.split('/').last,
            ));
          }
        }

        _newsList = newsList; // Isi _newsList dengan data berita
        notifyListeners(); // Beri tahu bahwa data telah berubah
      } else {
        throw Exception('Gagal mengambil berita');
      }
    } catch (e) {
      throw Exception('Gagal mengambil berita');
    }
  }

  Future<void> getBeritaById(String id) async {
    print('Mengambil detail berita dengan ID: $id');
    try {
      final response =
          await http.get(Uri.parse('https://jmtm.co.id/berita/detail/$id'));

      if (response.statusCode == 200) {
        final article = parse(response.body);
        final detailBerita = <DetailBerita>[];
        final articleTitle = article.querySelector('h2')?.text;
        final articleDate = article.querySelector('.text-muted')?.text;
        final articleDesc = article.querySelector('div.deskripsi')?.text;
        final articleImage =
            article.querySelector('img.mt-3')?.attributes['src'] ?? '';
        if (articleTitle != null && articleDate != null) {
          detailBerita.add(DetailBerita(
            title: articleTitle,
            date: articleDate,
            image: articleImage,
            desc: articleDesc ?? '',
            id: id,
          ));
        }

        _detailberita = detailBerita; // Isi _detailberita dengan data berita
        notifyListeners(); // Beri tahu bahwa data telah berubah
      } else {
        throw Exception('Gagal mengambil berita');
      }
    } catch (e) {
      throw Exception('Gagal mengambil berita');
    }
  }
}

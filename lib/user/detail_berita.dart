// ignore_for_file: prefer_const_constructors

import 'package:appjmtm/provider/berita_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailBeritaPage extends StatefulWidget {
  final String id;

  DetailBeritaPage({required this.id});

  @override
  State<DetailBeritaPage> createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.getBeritaById(widget.id);
    // Lakukan sesuatu ketika dependensi berubah (jika diperlukan)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Berita',
          style:
              GoogleFonts.heebo(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          final newsList = newsProvider.detailBerita;
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return Column(
                children: <Widget>[
                  Image.network(
                    "https://jmtm.co.id/${news.image}",
                    // width: 100,
                    // height: 100,
                    // fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          news.title,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.2,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          news.date,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          news.desc,
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
              // );
            },
          );
        },
      ),
    );
  }
}

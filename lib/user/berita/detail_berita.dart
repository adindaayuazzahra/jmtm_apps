// ignore_for_file: prefer_const_constructors

import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/styles.dart';
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
        backgroundColor: primaryColor,
        elevation: 6,
        shadowColor: secondaryColor,
        iconTheme: IconThemeData(color: putih),
        centerTitle: true,
        title: Text(
          'Berita JMTM ',
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
            color: putih,
          ),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          final newsList = newsProvider.detailBerita;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.network(
                      "https://jmtm.co.id/${news.image}",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              // );
            },
          );
        },
      ),
    );
  }
}

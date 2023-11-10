import 'package:appjmtm/provider/berita_provider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key? key}) : super(key: key);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  // void initState() {
  //   super.initState();
  //   final newsProvider = Provider.of<NewsProvider>(context, listen: true);
  //   newsProvider.fetchNews();
  // }

  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final newsProvider = Provider.of<NewsProvider>(context, listen: true);
  //   newsProvider.fetchNews();

  //   // Lakukan sesuatu ketika dependensi berubah (jika diperlukan)
  // }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchNews();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 6,
        shadowColor: secondaryColor,
        iconTheme: const IconThemeData(color: putih),
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
          final newsList = newsProvider.newsList;
          return RefreshIndicator(
            onRefresh: () async {
              final newsProvider =
                  Provider.of<NewsProvider>(context, listen: false);
              await newsProvider.fetchNews(); // Lakukan pembaruan data
              setState(() {}); // Perbarui tampilan
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: InkWell(
                    onTap: () {
                      String id = news.id;
                      Routes.router.navigateTo(context, '/berita/$id',
                          transition: TransitionType.fadeIn);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://jmtm.co.id/${news.image}',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          news.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          news.date,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

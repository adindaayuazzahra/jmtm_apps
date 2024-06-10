import 'package:appjmtm/componen/home_component.dart';
import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/user/berita/detail_berita.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key? key}) : super(key: key);

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  // @override
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 6,
        shadowColor: primaryColor,
        iconTheme: const IconThemeData(color: putih),
        centerTitle: true,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.angleLeft, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'JMTM News',
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.7,
            color: putih,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final newsProvider =
              Provider.of<NewsProvider>(context, listen: false);
          await newsProvider.fetchNews(); // Lakukan pembaruan data
          setState(() {}); // Perbarui tampilan
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Consumer<NewsProvider>(
            builder: (context, newsProvider, child) {
              final newsList = newsProvider.newsList;
              if (newsProvider.isLoading) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return const ShimmerBerita();
                  },
                );
              } else if (newsProvider.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsList[index];
                    return InkWell(
                      onTap: () {
                        String id = news.id;
                        // Routes.router.navigateTo(context, '/berita/$id',
                        //     transition: TransitionType.fadeIn);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBeritaPage(id: id),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
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
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            news.date,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  child: const Text('UHUYY'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

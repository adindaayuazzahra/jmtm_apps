// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:appjmtm/componen/home_component.dart';
import 'package:appjmtm/componen/subtitle.dart';
import 'package:appjmtm/componen/subtitlewithmore.dart';
import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "JMTM SERVICES",
              style: GoogleFonts.heebo(
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
                color: putih,
                fontSize: 16,
              ),
            ),
            Text(
              "PT Jasamarga Tollroad Maintenance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kuning,
                // color: Colors.amber.shade400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: putih,
              size: 20,
            ),
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.logout();

              Routes.router.navigateTo(context, '/login',
                  transition: TransitionType.inFromRight, replace: true);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          final newsProvider =
              Provider.of<NewsProvider>(context, listen: false);
          await newsProvider.fetchNews(); // Lakukan pembaruan data
          setState(() {}); // Perbarui tampilan
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderHome(),
              SizedBox(
                height: 40,
              ),
              Subtitle(
                text: 'Aplikasi JMTM',
              ),
              SizedBox(
                height: 20,
              ),

              // CONTAINER OVAL
              HeaderMenu(),
              SizedBox(
                height: 50,
              ),
              SubtitleWithMore(
                text: "Berita Terbaru",
                press: () {
                  Routes.router.navigateTo(context, '/berita',
                      transition: TransitionType.inFromRight);
                },
              ),
              SizedBox(
                height: 10,
              ),
              BeritaHome(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BeritaHome extends StatelessWidget {
  const BeritaHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchNews();
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        final newsList = newsProvider.newsList;
        // print(newsList);
        final limitedNewsList = newsList.take(3).toList();
        if (newsProvider.isLoading) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: limitedNewsList.length,
            itemBuilder: (context, index) {
              return ShimmerBerita();
            },
          );
        } else if (newsProvider.isNotEmpty) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: limitedNewsList.length,
            itemBuilder: (context, index) {
              final news = limitedNewsList[index];
              return InkWell(
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
                        color: secondaryColor.withOpacity(0.5),
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
                        height: 1.1,
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
              );
            },
          );
        } else {
          return Container(
            child: const Text('UHUYY'),
          );
        }
      },
    );
  }
}

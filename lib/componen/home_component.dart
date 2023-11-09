// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, camel_case_types

import 'package:appjmtm/provider/berita_provider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:html/parser.dart';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// HEADER HOME
class headerHome extends StatelessWidget {
  const headerHome({
    super.key,
    required this.nama,
    required this.npp,
    required this.jabatan,
  });
  final String nama;
  final String npp;
  final String jabatan;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          // INI UNTUK NAMA JABATAN DAN FOTO
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 15,
                    color: primaryColor.withOpacity(0.5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ0LPI4pp96oW6hU-0-wO6Aa9xsjG38aPUFQ&usqp=CAU'),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  // SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: size.width * 0.54,
                        child: Text(
                          '$nama',
                          // textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.heebo(
                            height: 1,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: size.width * 0.54,
                        child: Text(
                          '($npp) $jabatan ',
                          // textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.heebo(
                            height: 1.1,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// BERITA HOME
class Berita extends StatelessWidget {
  Berita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        final newsList = newsProvider.newsList;
        final limitedNewsList = newsList.take(3).toList();
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
            );
          },
        );
      },
    );
  }
}



  // Future<List<Map<String, dynamic>>> fetchNews() async {
  //   try {
  //     final response = await http.get(Uri.parse('https://jmtm.co.id/berita'));

  //     if (response.statusCode == 200) {
  //       final document = parse(response.body);
  //       final newsList = <Map<String, dynamic>>[];

  //       final articleElements = document.querySelectorAll('div.card');
  //       for (var article in articleElements) {
  //         final articleLink = article.querySelector('a')?.attributes['href'];
  //         final articleTitle = article.querySelector('.card-title')?.text;
  //         final articleDate = article.querySelector('.text-muted')?.text;
  //         final articleImage = article.querySelector('img')?.attributes['src'];

  //         if (articleTitle != null && articleDate != null) {
  //           newsList.add({
  //             'title': articleTitle,
  //             'date': articleDate,
  //             'image': articleImage,
  //             'link': articleLink,
  //           });
  //         }
  //       }

  //       return newsList;
  //     } else {
  //       throw Exception('Gagal mengambil berita');
  //     }
  //   } catch (e) {
  //     throw Exception('Gagal mengambil berita');
  //   }
  // }


     // return FutureBuilder(
    //   future: fetchNews(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return CircularProgressIndicator();
    //     } else if (snapshot.hasError) {
    //       return Text('Gagal mengambil berita.');
    //     } else {
    //       final newsList = snapshot.data;

    //       // Batasi jumlah berita yang ditampilkan menjadi 3.
    //       final limitedNewsList = newsList?.take(3).toList();

    //       return ListView.builder(
    //         physics:
    //             NeverScrollableScrollPhysics(), // Agar tidak dapat di-scroll
    //         shrinkWrap: true,
    //         itemCount: limitedNewsList?.length ?? 0,
    //         itemBuilder: (context, index) {
    //           final news = limitedNewsList![index];
    //           return InkWell(
    //             onTap: () {},
    //             child: Container(
    //               alignment: Alignment.center,
    //               margin: EdgeInsets.symmetric(
    //                 vertical: 8.0,
    //                 horizontal: 24,
    //               ),
    //               padding: EdgeInsets.symmetric(
    //                 vertical: 5,
    //               ),
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(8),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: secondaryColor.withOpacity(0.5), // Warna shadow
    //                     spreadRadius: 3, // Radius shadow
    //                     blurRadius: 5, // Blur shadow
    //                     offset: Offset(0, 3), // Offset shadow
    //                   ),
    //                 ],
    //               ),
    //               child: ListTile(
    //                 leading: ClipRRect(
    //                   borderRadius: BorderRadius.circular(8),
    //                   child: Image.network(
    //                     'https://jmtm.co.id/${news['image']}',
    //                     width: 100,
    //                     height: 100,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //                 title: Text(
    //                   news['title'],
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: GoogleFonts.heebo(
    //                     height: 1,
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 subtitle: Text(
    //                   news['date'],
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(
    //                     // height: 1,
    //                     fontSize: 12,
    //                     // fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //   },
    // );
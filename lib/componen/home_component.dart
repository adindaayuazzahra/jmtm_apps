// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, camel_case_types

import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:appjmtm/user/webview/webview.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.archive_outlined),
          color: secondaryColor,
          iconSize: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Webview(
                  url:
                      'https://e-sip.jmtm.co.id', // Ganti dengan URL yang diinginkan
                  title: 'E-Sip', // Ganti dengan URL yang diinginkan
                ),
              ),
            );
          },
        ),
        Text(
          "E-Sip",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              height: 1,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Berita extends StatelessWidget {
  const Berita({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        final newsList = newsProvider.newsList;
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

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
                  Consumer<AuthProvider>(
                    builder: (context, userProvider, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.54,
                            child: Text(
                              '${authProvider.user.nama}',
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
                              '(${authProvider.user.npp}) - ${authProvider.user.jabatan} ',
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
                      );
                    },
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

class ShimmerBerita extends StatelessWidget {
  const ShimmerBerita({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          leading: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 0, 0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 0, 0),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          subtitle: Container(
              width: double.infinity,
              height: 12,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 0, 0),
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:appjmtm/routes.dart';
// import 'package:fluro/fluro.dart';
import 'package:appjmtm/componen/home_component.dart';
import 'package:appjmtm/provider/berita_provider.dart';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<List<Map<String, dynamic>>> fetchNews() async {
//   final response = await http.get(Uri.parse('URL_SITUS_BERITA'));

//   if (response.statusCode == 200) {
//     final document = parse(response.body);
//     final newsList = <Map<String, dynamic>>[];

//     final articleElements = document.querySelectorAll('div.card');
//     for (var article in articleElements) {
//       final articleTitle = article.querySelector('.card-title')?.text;
//       final articleDate = article.querySelector('.text-muted')?.text;
//       final articleImage = article.querySelector('img')?.attributes['src'];

//       if (articleTitle != null && articleDate != null) {
//         newsList.add({
//           'title': articleTitle,
//           'date': articleDate,
//           'image': articleImage,
//         });
//       }
//     }

//     return newsList;
//   } else {
//     throw Exception('Gagal mengambil berita');
//   }
// }
class Home extends StatefulWidget {
  final String token;
  Home({super.key, required this.token});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  // void initState() {
  //   super.initState();
  //   final newsProvider = Provider.of<NewsProvider>(context, listen: true);
  //   newsProvider.fetchNews();
  // }
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newsProvider = Provider.of<NewsProvider>(context, listen: true);
    newsProvider.fetchNews();

    // Lakukan sesuatu ketika dependensi berubah (jika diperlukan)
  }

  @override
  Widget build(BuildContext context) {
    // // Dekode token untuk mendapatkan data.
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    String nama = decodedToken['nama'];
    String npp = decodedToken['npp'];
    String jabatan = decodedToken['jabatan'];
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
              ),
              // style: GoogleFonts.playfairDisplay(
              //   fontWeight: FontWeight.bold,
              //   fontSize: 20,
              //   color: putih,
              // ),
            ),
            Text(
              "PT Jasamarga Tollroad Maintenance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.amber.shade400,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            headerHome(nama: nama, npp: npp, jabatan: jabatan),
            SizedBox(
              height: 20,
            ),
            Berita(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

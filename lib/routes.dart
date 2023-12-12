import 'package:appjmtm/login/login.dart';
import 'package:appjmtm/user/Home.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:appjmtm/user/berita/berita.dart';
import 'package:appjmtm/user/berita/detail_berita.dart';
import 'package:appjmtm/user/navigation.dart';
import 'package:appjmtm/user/profil.dart';
import 'package:appjmtm/user/test.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static FluroRouter router = FluroRouter();

  static void configureRoutes() {
    // Definisikan rute-rute aplikasi di sini
    router.define(
      '/home',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return Home();
        },
      ),
    );
    router.define(
      '/berita',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return BeritaPage();
        },
      ),
    );
    router.define(
      '/profil',
      handler: Handler(
        handlerFunc: (context, parameters) {
          // final token = parameters['token']!.first;
          return Profil();
        },
      ),
    );

    // router.define(
    //   '/webview/:url/:title',
    //   handler: Handler(
    //     handlerFunc: (context, params) {
    //       final url = params['url']![0];
    //       print('URl dari rute: $url');
    //       final title = params['title']![0];
    //       return Webview(url: url, title: title);
    //     },
    //   ),
    // );
    router.define(
      '/berita/:id',
      handler: Handler(
        handlerFunc: (context, parameters) {
          final id = parameters['id']!.first;
          return DetailBeritaPage(
            id: id,
          );
        },
      ),
    );

    router.define(
      '/absensi/:token',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return Absensi();
        },
      ),
    );
    router.define(
      '/login',
      handler: Handler(handlerFunc: (context, parameters) => Login()),
    );
    router.define(
      '/test',
      handler: Handler(handlerFunc: (context, parameters) => Test()),
    );
    router.define(
      '/navigation',
      handler: Handler(handlerFunc: (context, parameters) => Navigation()),
    );
    // Tambahkan rute-rute lain sesuai kebutuhan Anda
  }
}

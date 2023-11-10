import 'package:appjmtm/login/login.dart';
import 'package:appjmtm/user/Home.dart';
import 'package:appjmtm/user/berita/berita.dart';
import 'package:appjmtm/user/berita/detail_berita.dart';
import 'package:appjmtm/user/navigation.dart';
import 'package:appjmtm/user/profil.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static FluroRouter router = FluroRouter();

  static void configureRoutes() {
    // Definisikan rute-rute aplikasi di sini
    router.define(
      '/home/:token',
      handler: Handler(
        handlerFunc: (context, parameters) {
          final token = parameters['token']!.first;
          return Home(
            token: token,
          );
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
      '/profil/:token',
      handler: Handler(
        handlerFunc: (context, parameters) {
          final token = parameters['token']!.first;
          return Profil(
            token: token,
          );
        },
      ),
    );
    router.define(
      '/berita/:id',
      handler: Handler(
        handlerFunc: (context, parameters) {
          final id = parameters['id']!.first;
          print('ID dari rute: $id');
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
          final token = parameters['token']!.first;
          return Profil(
            token: token,
          );
        },
      ),
    );
    router.define(
      '/login',
      handler: Handler(handlerFunc: (context, parameters) => Login()),
    );
    router.define(
      '/navigation',
      handler: Handler(handlerFunc: (context, parameters) => Navigation()),
    );
    // Tambahkan rute-rute lain sesuai kebutuhan Anda
  }
}

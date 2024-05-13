import 'package:appjmtm/login/login.dart';
import 'package:appjmtm/user/Home.dart';
import 'package:appjmtm/user/absensi/absensi.dart';
import 'package:appjmtm/user/absensi/history_absen.dart';
import 'package:appjmtm/user/berita/berita.dart';
import 'package:appjmtm/user/berita/detail_berita.dart';
import 'package:appjmtm/user/navigation.dart';
import 'package:appjmtm/user/profil/gantipassword.dart';
import 'package:appjmtm/user/profil/infokaryawan.dart';
import 'package:appjmtm/user/profil/jabatan.dart';
import 'package:appjmtm/user/profil/profil.dart';
import 'package:fluro/fluro.dart';

class Routes {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    // Definisikan rute-rute aplikasi di sini
    router.define(
      '/home',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return const Home();
        },
      ),
    );

    router.define(
      '/berita',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return const BeritaPage();
        },
      ),
    );

    router.define(
      '/history_absen',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return const HistoryAbsen();
        },
      ),
    );
    router.define(
      '/profil',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return const Profil();
        },
      ),
    );

    router.define(
      "/info/karyawan",
      handler:
          Handler(handlerFunc: (context, parameters) => const Infokaryawan()),
    );

    router.define(
      "/ganti_password",
      handler:
          Handler(handlerFunc: (context, parameters) => const Gantipassword()),
    );

    router.define(
      '/jabatan',
      handler: Handler(
        handlerFunc: (context, parameters) {
          return const Jabatan();
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
          return const Absensi();
        },
      ),
    );
    router.define(
      '/login',
      handler: Handler(handlerFunc: (context, parameters) => const Login()),
    );

    router.define(
      '/navigation',
      handler:
          Handler(handlerFunc: (context, parameters) => const Navigation()),
    );
    // Tambahkan rute-rute lain sesuai kebutuhan Anda
  }
}

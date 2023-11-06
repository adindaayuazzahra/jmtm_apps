import 'package:appjmtm/login/login.dart';
import 'package:appjmtm/user/Home.dart';
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

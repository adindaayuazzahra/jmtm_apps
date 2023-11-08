// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.dark,
    // systemNavigationBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  Routes.configureRoutes();
  // checkLoginStatus(context);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // checkLoginStatus(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JMTM SERVICES',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(seconds: 2)); // Tunggu selama 2 detik
    checkLoginStatus(context);
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Gantilah dengan key yang sesuai

    if (token != null) {
      Routes.router.navigateTo(context, '/navigation',
          transition: TransitionType.fadeIn);
      // Routes.router.navigateTo(context, '/home/$token',
      //     transition: TransitionType.fadeIn);
    } else {
      // Pengguna belum login, navigasi ke halaman login
      Routes.router
          .navigateTo(context, '/login', transition: TransitionType.fadeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black.withOpacity(0.2),
    ));
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          child: Image.asset('assets/images/jmtm.png')),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:appjmtm/provider/AbsenProvider.dart';
import 'package:appjmtm/provider/BeritaProvider.dart';
import 'package:appjmtm/provider/EducationProvider.dart';
import 'package:appjmtm/provider/HistoryAbsenProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/common/routes.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id');
  await AuthProvider().autoLogin();
  Routes.configureRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(create: (_) => NewsProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<AbsenProvider>(create: (_) => AbsenProvider()),
        ChangeNotifierProvider<HistoryAbsenProvider>(
            create: (_) => HistoryAbsenProvider()),
        ChangeNotifierProvider(create: (_) => EducationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.router.generator,
        title: 'JMTM SERVICES',
        theme: ThemeData(
          splashColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: Splash(),
      ),
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
    await Future.delayed(Duration(seconds: 2));
    checkLoginStatus(context);
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.autoLogin();

    // print(authProvider.isAuthenticated);

    if (authProvider.isAuthenticated) {
      Routes.router.navigateTo(context, '/navigation',
          transition: TransitionType.fadeIn);
    } else {
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
        child: Image.asset('assets/images/jmtm.png'),
      ),
    );
  }
}

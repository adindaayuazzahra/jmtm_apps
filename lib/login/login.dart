import 'package:appjmtm/login/page_one.dart';
import 'package:appjmtm/login/page_two.dart';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          _currentPage == 0 ? unguTua : Colors.black.withOpacity(0.2),
    ));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: _currentPage == 0 ? unguTua : putih,
        body: PageView(
          controller: _controller,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarIconBrightness:
                  _currentPage == 0 ? Brightness.light : Brightness.dark,
              systemNavigationBarColor:
                  _currentPage == 0 ? unguTua : Colors.black.withOpacity(0.2),
            ));

            // Menyembunyikan keyboard saat halaman digeser kembali ke halaman sebelumnya
            if (_currentPage == 0) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          children: const <Widget>[
            Page_one(),
            Page_two(),
          ],
        ),
        // bottomNavigationBar: _buildBottomBar(),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10), // Atur warna latar belakang di sini
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(2, (int index) {
          return Container(
            width: 10,
            height: 8,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index
                  ? Colors.deepPurple
                  : const Color.fromARGB(255, 218, 218, 218),
            ),
          );
        }),
      ),
    );
  }
}

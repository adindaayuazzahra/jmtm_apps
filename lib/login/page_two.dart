// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Page_two extends StatefulWidget {
  const Page_two({super.key});

  @override
  State<Page_two> createState() => _Page_twoState();
}

class _Page_twoState extends State<Page_two> {
  final TextEditingController nppController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Future<void> login(BuildContext context) async {
  Future<void> login() async {
    final response = await http.post(
      Uri.parse('https://apitest.proyekskripsi.site/api/login'),
      body: {
        'npp': nppController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Navigasi ke halaman utama
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => Home(token: token),
      // ));

      Routes.router.navigateTo(context, '/navigation',
          transition: TransitionType.inFromRight);
    } else {
      // Size size = MediaQuery.of(context).size;
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['error'];
      // Tampilkan dialog kesalahan jika terjadi kesalahan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            content: Container(
              alignment: Alignment.center,
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Lottie.asset('assets/lottie/silang.json'),
                  const SizedBox(height: 20),
                  Text(
                    'Login Gagal \n$errorMessage'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: unguMuda,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tutup'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: putih,
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // color: Colors.amber,
                margin: EdgeInsets.only(top: size.height * 0.06),
                padding: const EdgeInsets.only(right: 24, left: 24),
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/jmtm.png",
                  width: size.width * 0.35,
                ),
              ),
              SizedBox(height: size.height * 0.16),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Haloo, \nSilahkan Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            fontSize: 36),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "NPP",
                        prefixIcon: const Icon(Icons.person),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              50), // Atur borderRadius di sini
                        ),
                      ),
                      controller: nppController,
                      autofocus: false,
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              50), // Atur borderRadius di sini
                        ),
                      ),
                      obscureText: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              // side: BorderSide(color: Colors.red)
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(size.width, 50.0)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(unguMuda)),
                      onPressed: () {
                        login();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text(
                        "Login".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: putih,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset("assets/images/top1.png", width: size.width),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Image.asset("assets/images/top2.png", width: size.width),
        ),
      ],
    );
  }
}

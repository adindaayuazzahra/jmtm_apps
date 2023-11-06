// ignore_for_file: prefer_const_constructors

import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page_one extends StatelessWidget {
  const Page_one({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.height * 0.06),
            padding: EdgeInsets.only(right: 24, left: 24),
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/images/logojmtmputih.png",
              width: size.width * 0.35,
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Lottie.asset('assets/lottie/welcome_login.json'),
                SizedBox(height: size.height * 0.05),
                Text(
                  "Selamat Datang \ndi JMTM Services!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.16,
                      fontWeight: FontWeight.bold,
                      color: putih,
                      fontSize: 30),
                ),
                SizedBox(height: size.height * 0.04),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla egestas, lorem ac aliquam malesuada, nisi justo accumsan est, sit amet posuere urna nibh eget enim.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.2,
                      fontWeight: FontWeight.w300,
                      color: putih,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

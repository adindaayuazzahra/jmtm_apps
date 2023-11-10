import 'package:flutter/material.dart';

class Absensi extends StatelessWidget {
  final String token;
  const Absensi({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}

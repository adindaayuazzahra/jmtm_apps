import 'dart:convert';

import 'package:appjmtm/common/styles.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Gantipassword extends StatefulWidget {
  const Gantipassword({Key? key}) : super(key: key);

  @override
  _GantipasswordState createState() => _GantipasswordState();
}

class _GantipasswordState extends State<Gantipassword> {
  final TextEditingController passold = TextEditingController();
  final TextEditingController passnew = TextEditingController();
  final TextEditingController konfirmasi = TextEditingController();
  bool _showPassold = false;
  bool _showPassword = false;
  bool _showkonfirm = false;
  Future<void> gantiPassword(String npp) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.8.0.4:8000/ganti_password'),
        body: {
          'npp': npp,
          'pass_old': passold.text,
          'pass_new': passnew.text,
          'pass_confirm': konfirmasi.text,
          'validate': 'ANAKKAMPRETMAULEWAT',
        },
      );
      // print('${apiUrl}ganti_password');
      if (response.statusCode == 200) {
        // ini pengen feedback shwodialaog ke halaman ganti password
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(responseData);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: Lottie.asset('assets/lottie/berhasil.json', height: 100),
              title: Text(
                'Success',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                responseData['text'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        passold.clear();
        passnew.clear();
        konfirmasi.clear();
      } else {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(responseData);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              icon: Lottie.asset('assets/lottie/silang.json', height: 100),
              title: Text(
                responseData['head'],
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                responseData['message'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error during login: $e');
      // print('User Data: $_user');
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 6,
        centerTitle: true,
        shadowColor: secondaryColor,
        iconTheme: const IconThemeData(color: putih),
        title: Text(
          'Ganti Password',
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.7,
            color: putih,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Masukkan Password Lama Anda',
                style: GoogleFonts.heebo(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 13),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password Baru",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassold =
                            !_showPassold; // Toggle status _showPassold
                      });
                    },
                    child: Icon(
                      _showPassold ? Icons.visibility : Icons.visibility_off,
                      color: _showPassold
                          ? secondaryColor
                          : Colors
                              .grey, // Ubah warna ikon sesuai status _showPassold
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                obscureText:
                    !_showPassold, // Gunakan !(_showPassold) agar password tersembunyi jika _showPassword true
                controller: passold,
              ),
              SizedBox(height: 15),
              Text(
                'Masukkan Password Baru Anda',
                style: GoogleFonts.heebo(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 13),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password Baru",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showPassword =
                            !_showPassword; // Toggle status _showPassword
                      });
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: _showPassword
                          ? secondaryColor
                          : Colors
                              .grey, // Ubah warna ikon sesuai status _showPassword
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                obscureText:
                    !_showPassword, // Gunakan !(_showPassword) agar password tersembunyi jika _showPassword true
                controller: passnew,
              ),
              SizedBox(height: 15),
              Text(
                'Konfirmasi Password Baru',
                style: GoogleFonts.heebo(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 13),
              TextField(
                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showkonfirm =
                            !_showkonfirm; // Toggle status _showkonfirm
                      });
                    },
                    child: Icon(
                      _showkonfirm ? Icons.visibility : Icons.visibility_off,
                      color: _showkonfirm
                          ? secondaryColor
                          : Colors
                              .grey, // Ubah warna ikon sesuai status _showkonfirm
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                obscureText:
                    !_showkonfirm, // Gunakan !(_showPassword) agar password tersembunyi jika _showPassword true
                controller: konfirmasi,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shadowColor: primaryColor,
                    backgroundColor: secondaryColor,
                  ),
                  onPressed: () {
                    String npp = authProvider.user.user.dakar.npp;
                    // authProvider.gantiPassword(
                    //     npp, passold, passnew, konfirmasi);
                    gantiPassword(npp);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'GANTI PASSWORD',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.heebo(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                            fontSize: 16,
                            color: putih,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

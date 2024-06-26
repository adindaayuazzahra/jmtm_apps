// ignore_for_file: use_build_context_synchronously

import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Page_two extends StatefulWidget {
  const Page_two({super.key});

  @override
  State<Page_two> createState() => _Page_twoState();
}

class _Page_twoState extends State<Page_two> {
  final TextEditingController nppController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showpass = false;
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
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showpass = !_showpass; // Toggle status _showpass
                            });
                          },
                          child: Icon(
                            _showpass ? Icons.visibility : Icons.visibility_off,
                            color: _showpass
                                ? primaryColor
                                : Colors
                                    .grey, // Ubah warna ikon sesuai status _showpass
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      obscureText:
                          !_showpass, // Gunakan !(_showPassold) agar password tersembunyi jika _showPassword true
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),
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
                              MaterialStateProperty.all<Color>(primaryColor)),
                      // onPressed: () {
                      //   login();
                      //   FocusScope.of(context).unfocus();
                      // },
                      onPressed: () async {
                        // try {
                        // String npp = nppController.text;
                        // String password = passwordController.text;
                        // if (npp.isEmpty || password.isEmpty) {
                        //   return showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         icon: Lottie.asset('assets/lottie/silang.json',
                        //             height: 130),
                        //         surfaceTintColor: putih,
                        //         backgroundColor: putih,
                        //         content: Text(
                        //           'Login Gagal \nPassword atau Username Tidak Boleh Kosong! '
                        //               .toUpperCase(),
                        //           textAlign: TextAlign.center,
                        //           style: const TextStyle(
                        //               height: 1.2,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.black,
                        //               fontSize: 14),
                        //         ),
                        //         actions: [
                        //           TextButton(
                        //             child: Container(
                        //               padding: EdgeInsets.zero,
                        //               margin: EdgeInsets.zero,
                        //               alignment: Alignment.center,
                        //               height: 40,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(20),
                        //                 color: primaryColor,
                        //               ),
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Text(
                        //                     'Tutup'.toUpperCase(),
                        //                     style: const TextStyle(
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.bold,
                        //                       color: putih,
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //           ),
                        //         ],
                        //       );
                        //     },
                        //   );
                        // }

                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        await authProvider.login(
                            context, nppController, passwordController);
                        // Routes.router.navigateTo(
                        //   context,
                        //   '/navigation',
                        //   transition: TransitionType.inFromRight,
                        // );
                        // } catch (e) {
                        //   // Tangkap pengecualian dan tampilkan dialog kesalahan
                        //   // final responseJson = jsonDecode(response.body);
                        //   // final errorMessage = responseJson['error'];
                        //   // Tampilkan dialog kesalahan jika terjadi kesalahan

                        // }
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
          top: -5,
          right: -8,
          child: Image.asset("assets/images/top1.png", width: size.width),
        ),
        Positioned(
          top: -5,
          right: -8,
          child: Image.asset("assets/images/top2.png", width: size.width),
        ),
      ],
    );
  }
}

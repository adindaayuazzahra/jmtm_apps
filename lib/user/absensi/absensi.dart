// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_string_interpolations, unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appjmtm/provider/AbsenProvider.dart';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/routes.dart';
import 'package:appjmtm/styles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class Absensi extends StatefulWidget {
  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  late StreamController<DateTime> _streamController;
  late DateTime _currentTime;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<DateTime>();
    _currentTime = DateTime.now();

    // Setiap detik, tambahkan waktu sekarang ke stream
    Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      if (mounted) {
        _currentTime = DateTime.now();
        if (!_streamController.isClosed) {
          _streamController.add(_currentTime);
        }
      }
    });
    // Memanggil metode fetchData saat halaman diinisialisasi
  }

  Future<LocationData?> _currenctLocation() async {
    bool serviceEnable;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnable = await location.serviceEnabled();

    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Future<String?> _getAddress(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<void> sendDataAndImageToApi() async {
    setState(() {
      isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    //DATA
    // Get the location
    final locationData = await _currenctLocation();
    if (locationData == null) {
      print('LOKASI TIDAK TERDETEKASI');
      return;
    }

    // Get the address
    final address =
        await _getAddress(locationData.latitude!, locationData.longitude!);
    if (address == null) {
      print('ALAMAT TIDAK TERDETEKSI');
      return;
    }

    // get tanggal dan jam
    final DateTime tanggalHariIni = DateTime.now();
    final DateTime jam = DateTime.now();
    final String formattedDate =
        DateFormat('d-M-yyyy', 'id').format(tanggalHariIni);
    final String formattedTime = DateFormat('HH:mm:ss', 'id').format(jam);
    final npp = '${authProvider.user.user.dakar.npp}';
    final latitude = locationData.latitude.toString();
    final longitude = locationData.longitude.toString();
    final keluar = '';
    final status = '0';
    final validate = 'ANAKKAMPRETMAULEWAT';
    final imageFile = File(pickedFile.path);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.2.65:8000/absensi'),
    );

    // Menambahkan data dan gambar ke request
    request.fields['npp'] = npp;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['masuk'] = formattedTime;
    request.fields['tanggal'] = formattedDate;
    request.fields['keluar'] = keluar;
    request.fields['alamat'] = address;
    request.fields['status'] = status;
    request.fields['validate'] = validate;
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path,
        filename: '${npp} ${formattedTime} ${formattedDate}.jpg'));

    // Mengirim request
    var response = await request.send();

    // RESPONSE DARI API STREAMED RESPONSE
    final String responseData = await utf8.decodeStream(response.stream);
    // Parse and use the response body
    final parsedData = json.decode(responseData);
    // Handle the parsed data as needed
    final message = parsedData['message'];

    //JIKA BERHASIL MENGIRIM DATA
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Lottie.asset('assets/lottie/berhasil.json', height: 100),
            surfaceTintColor: putih,
            backgroundColor: putih,
            content: Text(
              '${message}'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14),
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
                    color: secondaryColor,
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
                onPressed: () async {
                  final absenProvider =
                      Provider.of<AbsenProvider>(context, listen: false);
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  final DateTime tanggalHariIni = DateTime.now();
                  final String formattedDate =
                      DateFormat('yyyy-M-d', 'id').format(tanggalHariIni);
                  final npp = '${authProvider.user.user.dakar.npp}';
                  await absenProvider.fetchDataAbsen(
                      npp, formattedDate); // Lakukan pembaruan data
                  setState(() {});
                  Navigator.of(context).pop(); // Perbarui tampilan
                },
              ),
            ],
          );
        },
      );
      print(
          'Berhasil Mengirim Data dan Gambar ke API. Status code: ${response.statusCode}');
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Lottie.asset('assets/lottie/silang.json', height: 100),
            surfaceTintColor: putih,
            backgroundColor: putih,
            content: Text(
              '${message}'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14),
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
                    color: secondaryColor,
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
                  setState(() {});
                },
              ),
            ],
          );
        },
      );
      print(
          'Gagal mengirim data dan gambar ke API. Status code: ${response.statusCode}');
    }
  }

  Future<void> sendDataAndImageToApiKeluar() async {
    setState(() {
      isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    //DATA
    // Get the location
    final locationData = await _currenctLocation();
    if (locationData == null) {
      print('LOKASI TIDAK TERDETEKASI');
      return;
    }

    // Get the address
    final address =
        await _getAddress(locationData.latitude!, locationData.longitude!);
    if (address == null) {
      print('ALAMAT TIDAK TERDETEKSI');
      return;
    }

    // get tanggal dan jam
    final DateTime tanggalHariIni = DateTime.now();
    final DateTime jam = DateTime.now();
    final String formattedDate =
        DateFormat('d-M-yyyy', 'id').format(tanggalHariIni);
    final String formattedTime = DateFormat('HH:mm:ss', 'id').format(jam);
    final npp = '${authProvider.user.user.dakar.npp}';
    final latitude = locationData.latitude.toString();
    final longitude = locationData.longitude.toString();
    final masuk = '';
    final status = '1';
    final validate = 'ANAKKAMPRETMAULEWAT';
    final imageFile = File(pickedFile.path);

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.2.65:8000/absensi'),
    );

    // Menambahkan data dan gambar ke request
    request.fields['npp'] = npp;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['masuk'] = masuk;
    request.fields['tanggal'] = formattedDate;
    request.fields['keluar'] = formattedTime;
    request.fields['alamat'] = address;
    request.fields['status'] = status;
    request.fields['validate'] = validate;
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path,
        filename: '${npp} ${formattedTime} ${formattedDate}.jpg'));

    // Mengirim request
    var response = await request.send();

    // RESPONSE DARI API STREAMED RESPONSE
    final String responseData = await utf8.decodeStream(response.stream);
    // Parse and use the response body
    final parsedData = json.decode(responseData);
    // Handle the parsed data as needed
    final message = parsedData['message'];

    //JIKA BERHASIL MENGIRIM DATA
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Lottie.asset('assets/lottie/berhasil.json', height: 100),
            surfaceTintColor: putih,
            backgroundColor: putih,
            content: Text(
              '${message}'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14),
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
                    color: secondaryColor,
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
                onPressed: () async {
                  final absenProvider =
                      Provider.of<AbsenProvider>(context, listen: false);
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  final DateTime tanggalHariIni = DateTime.now();
                  final String formattedDate =
                      DateFormat('yyyy-M-d', 'id').format(tanggalHariIni);
                  final npp = '${authProvider.user.user.dakar.npp}';
                  await absenProvider.fetchDataAbsen(
                      npp, formattedDate); // Lakukan pembaruan data
                  setState(() {});
                  Navigator.of(context).pop(); // Perbarui tampilan
                },
                // {
                //   setState(() {

                //   });
                //   Navigator.of(context).pop();
                // },
              ),
            ],
          );
        },
      );
      print(
          'Berhasil Mengirim Data dan Gambar ke API. Status code: ${response.statusCode}');
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Lottie.asset('assets/lottie/silang.json', height: 100),
            surfaceTintColor: putih,
            backgroundColor: putih,
            content: Text(
              '${message}'.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14),
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
                    color: secondaryColor,
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
                  setState(() {});
                },
              ),
            ],
          );
        },
      );
      print(
          'Gagal mengirim data dan gambar ke API. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime tanggalHariIni = DateTime.now();

    String formattedDate = DateFormat('d MMM y', 'id').format(tanggalHariIni);

    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // final npp = '${authProvider.user.user.dakar.npp}';
    final absenProvider = Provider.of<AbsenProvider>(context, listen: false);
    // absenProvider.fetchDataAbsen(npp, formattedDate);
    final absenData = absenProvider.absenData;

    // print(absenData.absen.length);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: putih,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          elevation: 6,
          shadowColor: secondaryColor,
          iconTheme: const IconThemeData(color: putih),
          actions: <Widget>[
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.clockRotateLeft,
                size: 20,
              ),
              onPressed: () {
                Routes.router.navigateTo(context, '/history_absen',
                    transition: TransitionType.inFromRight);
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
          title: Text(
            'Presensi',
            style: GoogleFonts.heebo(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7,
              color: putih,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<LocationData?>(
                future: _currenctLocation(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    final LocationData currentLocation = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.4,
                          child: Stack(
                            children: [
                              Maps(
                                  size: size, currentLocation: currentLocation),

                              // TANGGAL JAM
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  // margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                    ),
                                    color: kuning,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FaIcon(
                                        FontAwesomeIcons.calendar,
                                        color: putih,
                                        size: 15,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "$formattedDate",
                                        style: GoogleFonts.heebo(
                                            color: putih,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Spacer(),
                                      SizedBox(width: 20),
                                      FaIcon(
                                        FontAwesomeIcons.clock,
                                        color: putih,
                                        size: 15,
                                      ),
                                      SizedBox(width: 6),
                                      StreamBuilder<DateTime>(
                                        stream: _streamController.stream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            String formattedTime =
                                                DateFormat('HH:mm:ss', 'id')
                                                    .format(snapshot.data!);
                                            return Text(
                                              formattedTime,
                                              style: GoogleFonts.heebo(
                                                  color: putih,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          } else {
                                            return Container(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 4,
                                                strokeCap: StrokeCap.round,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              //TAB BAR
                              TabBarAbsen(),
                              Container(
                                height: size.height * 0.4,
                                child: TabBarView(
                                  children: <Widget>[
                                    //LOKASI
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: secondaryColor,
                                            ),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              const Text(
                                                'Halo, Berikut adalah lokasi kamu saat ini :',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.1,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 10),

                                              // MENAMPILKAN ALAMAT
                                              FutureBuilder<String?>(
                                                future: _getAddress(
                                                  currentLocation.latitude!,
                                                  currentLocation.longitude!,
                                                ),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<String?>
                                                        snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      '${snapshot.data}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.heebo(
                                                          // color: Colors.black,
                                                          height: 1.2,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    print(
                                                        "Error: ${snapshot.error}");
                                                    return Text(
                                                        "Error fetching address");
                                                  } else {
                                                    return const Text(
                                                        'Loading...');
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 20),

                                              // TOMBOL PRESENSI
                                              absenData.absen.length == 0
                                                  ? ElevatedButton(
                                                      onPressed: () {
                                                        (isLoading)
                                                            ? ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                                        content:
                                                                            Text('Tunggu ya,Sedang Memproses Presensi Kamu')))
                                                            : sendDataAndImageToApi();
                                                        // if (DateTime.now().hour < 10) {
                                                        //   // Lakukan aksi saat tombol ditekan
                                                        //   sendDataAndImageToApi();
                                                        // } else {
                                                        //   // Jika sudah lewat jam 10:00, tampilkan pesan atau berikan aksi lain
                                                        //   // Misalnya, tampilkan snackbar dengan pesan
                                                        //   ScaffoldMessenger.of(context)
                                                        //       .showSnackBar(
                                                        //     SnackBar(
                                                        //       content: Text(
                                                        //           'Tidak dapat melakukan absen setelah jam 10:00'),
                                                        //     ),
                                                        //   );
                                                        // }
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colors
                                                                    .green
                                                                    .shade700),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 11),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            (isLoading)
                                                                ? CircularProgressIndicator(
                                                                    color:
                                                                        kuning,
                                                                  )
                                                                : Text(
                                                                    'MASUK',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                            SizedBox(width: 8),
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .personWalkingArrowRight,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : (absenData.absen.length >=
                                                              1 &&
                                                          absenData.absen
                                                                  .length <
                                                              2)
                                                      ? ElevatedButton(
                                                          onPressed: () {
                                                            (isLoading)
                                                                ? ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text('Tunggu ya,Sedang Memproses Presensi Kamu')))
                                                                : sendDataAndImageToApiKeluar();
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        orange),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        11),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                (isLoading)
                                                                    ? CircularProgressIndicator(
                                                                        color:
                                                                            primaryColor)
                                                                    : Text(
                                                                        'KELUAR',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                    width: 8),
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .personWalkingArrowRight,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: size.width,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .green
                                                                  .shade400,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              FaIcon(FontAwesomeIcons
                                                                  .circleCheck),
                                                              const Text(
                                                                'Yey! Presensi Kamu sudah lengkap, \nJangan lupa besok absen lagi ya ...',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  height: 1.1,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    //PRESENSI
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (absenData.absen.length != 0)
                                              for (var absen in absenData.absen)
                                                Card(
                                                  color: putih,
                                                  surfaceTintColor:
                                                      secondaryColor,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 0),
                                                    child: ListTile(
                                                      leading: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.0), // Ganti nilai sesuai keinginan Anda
                                                        child: Image.network(
                                                          "http://192.168.2.65:8000/${absen.fotoLink}",
                                                          height: 70,
                                                          width: 70,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),

                                                      // subtitle: Text('Alamat: ${absen.alamat}'),
                                                      trailing: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'PRESENSI ${absen.status == "0" ? "Masuk" : "Keluar"}'
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              color: absen.status ==
                                                                      "0"
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: size.width *
                                                                0.54,
                                                            child: Text(
                                                              // '${authProvider.user.nama}',
                                                              '${absen.alamat}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .heebo(
                                                                height: 1,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${absen.status == "0" ? formatDateTime(absen.masuk) : formatDateTime(absen.keluar)}',
                                                            style: GoogleFonts.heebo(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          // Text(
                                                          //     'Waktu: ${absen.status == "0" ? absen.masuk : absen.keluar}'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            else
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Maaf, kamu belum melakukan presensi.',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 9,
                                                    ),
                                                    Lottie.asset(
                                                      'assets/lottie/silang.json',
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                },
              ),
              // SimpanPage(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

class TabBarAbsen extends StatelessWidget {
  const TabBarAbsen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: secondaryColor, // Sesuaikan dengan warna AppBar Anda
      ),
      child: TabBar(
        padding: EdgeInsets.all(6),
        dragStartBehavior: DragStartBehavior.start,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorPadding: EdgeInsets.all(5),
        indicator: BoxDecoration(
            color: orange, borderRadius: BorderRadius.circular(30)),
        tabs: [
          Tab(
            child: Text(
              'LOKASI',
              style: TextStyle(
                  color: putih,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1),
            ),
          ),
          Tab(
            child: Text(
              'PRESENSI',
              style: TextStyle(
                  color: putih,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }
}

class Maps extends StatelessWidget {
  const Maps({
    super.key,
    required this.size,
    required this.currentLocation,
  });

  final Size size;
  final LocationData currentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.4,
      child: SfMaps(
        layers: [
          MapTileLayer(
            initialFocalLatLng: MapLatLng(
                currentLocation.latitude!, currentLocation.longitude!),
            initialZoomLevel: 15, // Initial zoom level
            initialMarkersCount: 1,
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            markerBuilder: (BuildContext context, int index) {
              return MapMarker(
                latitude: currentLocation.latitude!,
                longitude: currentLocation.longitude!,
                child: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

String formatDateTime(String dateTimeString) {
  if (dateTimeString.isNotEmpty) {
    DateTime parsedDateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm:ss', 'id').format(parsedDateTime);
  } else {
    return 'Tanggal tidak valid'; // atau sesuaikan dengan nilai default lain jika diinginkan
  }
}

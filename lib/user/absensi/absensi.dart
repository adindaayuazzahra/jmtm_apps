// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appjmtm/provider/UserProvider.dart';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  File? _image;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<DateTime>();
    _currentTime = DateTime.now();

    // Setiap detik, tambahkan waktu sekarang ke stream
    Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      if (!_streamController.isClosed) {
        _streamController.add(_currentTime);
      }
    });
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

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      print('Image picked successfully: ${_image?.path}');
    } else {
      print('Image picking canceled');
    }
  }

  // Future<void> _sendAttendance() async {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);

  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     preferredCameraDevice: CameraDevice.front,
  //   );

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //     print('Image picked successfully: ${_image?.path}');
  //   } else {
  //     print('Image picking canceled');
  //   }
  //   if (_image == null) {
  //     print('ga ada foto');
  //     return;
  //   }

  //   // Get the location
  //   final locationData = await _currenctLocation();
  //   if (locationData == null) {
  //     print('ga ada lokasi');
  //     return;
  //   }

  //   // Get the address
  //   final address =
  //       await _getAddress(locationData.latitude!, locationData.longitude!);
  //   if (address == null) {
  //     print('ga ada alamat');
  //     return;
  //   }

  //   //get tanggal dan jam
  //   final DateTime tanggalHariIni = DateTime.now();
  //   final DateTime jam = DateTime.now();

  //   final String formattedDate =
  //       DateFormat('d-M-yyyy', 'id').format(tanggalHariIni);
  //   final String formattedTime = DateFormat('HH:mm:ss', 'id').format(jam);

  //   // Prepare your API request
  //   const apiUrl = 'http://192.168.2.65:8000/absensi';
  //   final apiBody = {
  //     'npp': '${authProvider.user.user.dakar.npp}',
  //     'latitude': locationData.latitude.toString(),
  //     'longitude': locationData.longitude.toString(),
  //     'address': address.toString(),
  //     'tanggal': formattedDate.toString(),
  //     'masuk': formattedTime.toString(),
  //     'keluar': '',
  //     'status': '0',
  //     'validate': 'ANAKKAMPRETMAULEWAT',
  //     // Add other necessary parameters
  //   };

  //   print('API URL: $apiUrl');
  //   print('API Body: $apiBody');
  //   print('Image Path: ${_image?.path}');
  //   // Prepare the multipart request
  //   final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
  //     ..fields.addAll(apiBody)
  //     ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

  //   try {
  //     // Print request headers and fields for debugging
  //     print('Request Headers: ${request.headers}');
  //     print('Request Fields: ${request.fields}');

  //     final response = await request.send();

  //     // Print response details for debugging
  //     print('Response Headers: ${response.headers}');
  //     print('Response Status Code: ${response.statusCode}');

  //     if (response.statusCode == 200) {
  //       // Handle a successful response from the API
  //       print('Attendance sent successfully!');
  //     } else {
  //       // Handle other response statuses
  //       print('Failed to send attendance. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle network errors or other exceptions
  //     print('Error sending attendance: $e');
  //   }
  // }

  // Future<void> _sendAttendance() async {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);

  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     preferredCameraDevice: CameraDevice.front,
  //   );

  //   if (pickedFile == null) {
  //     print('Image picking canceled');
  //     return;
  //   }

  //   final imageFile = File(pickedFile.path);

  //   var bytes = await rootBundle.load(imageFile);
  //   var buffer = bytes.buffer;
  //   var imageBytes =
  //       buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

  //   // Encode the bytes
  //   var base64Image = base64Encode(imageBytes);

  //   // if (pickedFile != null) {
  //   //   setState(() {
  //   //     _image = File(pickedFile.path);
  //   //   });
  //   //   print('Image picked successfully: ${_image?.path}');
  //   // } else {
  //   //   print('Image picking canceled');
  //   // }
  //   // if (_image == null) {
  //   //   print('ga ada foto');
  //   //   return;
  //   // }

  //   // Get the location
  //   final locationData = await _currenctLocation();
  //   if (locationData == null) {
  //     print('ga ada lokasi');
  //     return;
  //   }

  //   // Get the address
  //   final address =
  //       await _getAddress(locationData.latitude!, locationData.longitude!);
  //   if (address == null) {
  //     print('ga ada alamat');
  //     return;
  //   }

  //   // get tanggal dan jam
  //   final DateTime tanggalHariIni = DateTime.now();
  //   final DateTime jam = DateTime.now();

  //   final String formattedDate =
  //       DateFormat('d-M-yyyy', 'id').format(tanggalHariIni);
  //   final String formattedTime = DateFormat('HH:mm:ss', 'id').format(jam);

  //   // Prepare your API request
  //   final apiUrl = 'http://192.168.2.65:8000/absensi';

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: {
  //         'npp': '${authProvider.user.user.dakar.npp}',
  //         'latitude': locationData.latitude.toString(),
  //         'longitude': locationData.longitude.toString(),
  //         'address': address,
  //         'tanggal': formattedDate,
  //         'masuk': formattedTime,
  //         'keluar': '',
  //         'status': '0',
  //         'validate': 'ANAKKAMPRETMAULEWAT',
  //         'image': base64Image,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // Handle a successful response from the API
  //       print('Attendance sent successfully!');
  //     } else {
  //       // Handle other response statuses
  //       print('Failed to send attendance. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle network errors or other exceptions
  //     print('Error sending attendance: $e');
  //   }
  // }

  // Future<void> _sendAttendance() async {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);

  //   final pickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     preferredCameraDevice: CameraDevice.front,
  //   );

  //   if (pickedFile == null) {
  //     print('Image picking canceled');
  //     return;
  //   }

  //   final imageFile = File(pickedFile.path);

  //   try {
  //     final imageBytes = await imageFile.readAsBytes();
  //     var base64Image = base64Encode(imageBytes);

  //     // Get the location
  //     final locationData = await _currenctLocation();
  //     if (locationData == null) {
  //       print('ga ada lokasi');
  //       return;
  //     }

  //     // Get the address
  //     final address =
  //         await _getAddress(locationData.latitude!, locationData.longitude!);
  //     if (address == null) {
  //       print('ga ada alamat');
  //       return;
  //     }

  //     // get tanggal dan jam
  //     final DateTime tanggalHariIni = DateTime.now();
  //     final DateTime jam = DateTime.now();

  //     final String formattedDate =
  //         DateFormat('d-M-yyyy', 'id').format(tanggalHariIni);
  //     final String formattedTime = DateFormat('HH:mm:ss', 'id').format(jam);
  //     final apiBody = {
  //       'npp': '${authProvider.user.user.dakar.npp}',
  //       'latitude': locationData.latitude.toString(),
  //       'longitude': locationData.longitude.toString(),
  //       'address': address,
  //       'tanggal': formattedDate,
  //       'masuk': formattedTime,
  //       'keluar': '',
  //       'status': '0',
  //       'validate': 'ANAKKAMPRETMAULEWAT',
  //       'image': base64Image,
  //     };
  //     // Prepare your API request
  //     final apiUrl = 'http://192.168.2.65:8000/absensi';

  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: {
  //         'npp': '${authProvider.user.user.dakar.npp}',
  //         'latitude': locationData.latitude.toString(),
  //         'longitude': locationData.longitude.toString(),
  //         'address': address,
  //         'tanggal': formattedDate,
  //         'masuk': formattedTime,
  //         'keluar': '',
  //         'status': '0',
  //         'validate': 'ANAKKAMPRETMAULEWAT',
  //         'image': base64Image,
  //       },
  //     );
  //     print(apiBody);
  //     if (response.statusCode == 200) {
  //       // Handle a successful response from the API
  //       print('Attendance sent successfully!');
  //     } else {
  //       // Handle other response statuses
  //       print('Failed to send attendance. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle network errors or other exceptions
  //     print('Error sending attendance: $e');
  //   }
  // }

  Future<void> sendDataAndImageToApi() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile == null) {
      print('Image picking canceled');
      return;
    }

    //DATA
    // Get the location
    final locationData = await _currenctLocation();
    if (locationData == null) {
      print('ga ada lokasi');
      return;
    }

    // Get the address
    final address =
        await _getAddress(locationData.latitude!, locationData.longitude!);
    if (address == null) {
      print('ga ada alamat');
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

    // final compressedImage = await compressImage(File(pickedFile.path));

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
    // request.files.add(http.MultipartFile.fromBytes('image', compressedImage));

    // Mengirim request
    var response = await request.send();

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Lottie.asset('assets/lottie/berhasil.json', height: 100),
            surfaceTintColor: putih,
            backgroundColor: putih,
            content: Text(
              'BERHASIL MELAKUKAN PRESENSI MASUK',
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
          'Berhasil Mengirim Data dan Gambar ke API. Status code: ${response.statusCode}');
    } else {
      final uhuy = await response.stream.bytesToString();
      final jsonData = json.decode(uhuy);
      final erorrData = json.encode(jsonData);
      print(erorrData);
      // print(uhuy[]);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Lottie.asset('assets/lottie/silang.json', height: 100),
            surfaceTintColor: putih,
            backgroundColor: putih,
            content: Text(
              'xwx',
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
      // print('Response message: ${await response.stream.bytesToString()}');
    }
  }

  // Future<List<int>> compressImage(File imageFile) async {
  //   // Mengompres gambar dengan flutter_image_compress
  //   List<int> result = await FlutterImageCompress.compressWithList(
  //     imageFile.readAsBytesSync(),
  //     quality: 60, // Sesuaikan kualitas kompresi (0 - 100)
  //   );

  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    DateTime tanggalHariIni = DateTime.now();

    String formattedDate = DateFormat('d MMM y', 'id').format(tanggalHariIni);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            // tooltip: 'Show Snackbar',
            onPressed: () {
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
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  final LocationData currentLocation = snapshot.data;
                  return Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.42,
                        child: Stack(
                          children: [
                            Container(
                              height: size.height * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: SfMaps(
                                layers: [
                                  MapTileLayer(
                                    initialFocalLatLng: MapLatLng(
                                        currentLocation.latitude!,
                                        currentLocation.longitude!),
                                    initialZoomLevel: 15, // Initial zoom level
                                    initialMarkersCount: 1,
                                    urlTemplate:
                                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    markerBuilder:
                                        (BuildContext context, int index) {
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
                            ),

                            // TANGGAL JAM
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                // alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     offset: Offset(3, 0),
                                  //     blurRadius: 2,
                                  //     color: primaryColor.withOpacity(0.7),
                                  //   ),
                                  // ],
                                  color: secondaryColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    SizedBox(width: 16),
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
                        // padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: secondaryColor,
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  FutureBuilder<String?>(
                                    future: _getAddress(
                                      currentLocation.latitude!,
                                      currentLocation.longitude!,
                                    ),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String?> snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          '${snapshot.data}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.heebo(
                                              // color: Colors.black,
                                              height: 1.2,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        );
                                      } else if (snapshot.hasError) {
                                        print("Error: ${snapshot.error}");
                                        return Text("Error fetching address");
                                      } else {
                                        return const Text('Loading...');
                                      }
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     await _getImage();
                                  //     await _sendAttendance();
                                  //   },
                                  //   child:
                                  Container(
                                    width: size.width,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // await _getImage();
                                        // await _sendAttendance();
                                        sendDataAndImageToApi();
                                        // print('Button Pressed');
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                orange),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 11),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'MASUK',
                                              style: TextStyle(
                                                  color: putih,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(width: 8),
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .personWalkingArrowRight,
                                              color: putih,
                                              // size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                            ),
                            // ElevatedButton(
                            //   onPressed: () async {
                            //     await _getImage();
                            //     await _sendAttendance();
                            //   },
                            //   child: Text('Capture and Send Attendance'),
                            // ),
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
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

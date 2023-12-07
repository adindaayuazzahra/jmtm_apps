// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class Absensi extends StatefulWidget {
  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  late StreamController<DateTime> _streamController;
  late DateTime _currentTime;
  XFile? _image;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  Future<void> _sendAttendance() async {
    if (_image == null) {
      // Handle the case where no image is selected
      return;
    }

    // Get the location
    final locationData = await _currenctLocation();
    if (locationData == null) {
      // Handle the case where location data is not available
      return;
    }

    // Get the address
    final address =
        await _getAddress(locationData.latitude!, locationData.longitude!);
    if (address == null) {
      // Handle the case where address is not available
      return;
    }

    //get tanggal dan jam
    final DateTime tanggalHariIni = DateTime.now();
    final DateTime jam = DateTime.now();

    final String formattedDate =
        DateFormat('d-M-yyyy', 'id').format(tanggalHariIni);
    final String formattedTime = DateFormat('HH:mm:ss', 'id').format(jam);

    // Prepare your API request
    final apiUrl = 'YOUR_API_ENDPOINT';
    final apiBody = {
      'latitude': locationData.latitude.toString(),
      'longitude': locationData.longitude.toString(),
      'address': address.toString(),
      'tanggal': formattedDate.toString(),
      'masuk': formattedTime.toString(),
      // Add other necessary parameters
    };

    // Prepare the multipart request
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..fields.addAll(apiBody)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

    print(apiBody.values);

    // print(_image);

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        // Handle a successful response from the API
        print('Attendance sent successfully!');
      } else {
        // Handle other response statuses
        print('Failed to send attendance. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error sending attendance: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    DateTime tanggalHariIni = DateTime.now();
    // String formattedDate =
    //     "${tanggalHariIni.day}-${tanggalHariIni.month}-${tanggalHariIni.year}";
    String formattedDate = DateFormat('d MMM y', 'id').format(tanggalHariIni);
    // String formattedjam = DateFormat('h:mm a', 'id').format(tanggalHariIni);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        elevation: 6,
        shadowColor: secondaryColor,
        iconTheme: const IconThemeData(color: putih),
        centerTitle: true,
        title: Text(
          'Absensi',
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
                                      onPressed: () async {
                                        await _sendAttendance();
                                        await _getImage();
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

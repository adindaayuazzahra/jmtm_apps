// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:appjmtm/styles.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
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

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<DateTime>();
    _currentTime = DateTime.now();

    // Setiap detik, tambahkan waktu sekarang ke stream
    Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      _streamController.add(_currentTime);
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
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime tanggalHariIni = DateTime.now();
    // String formattedDate =
    //     "${tanggalHariIni.day}-${tanggalHariIni.month}-${tanggalHariIni.year}";
    String formattedDate = DateFormat('d MMM y', 'id').format(tanggalHariIni);
    // String formattedjam = DateFormat('h:mm a', 'id').format(tanggalHariIni);

    Size size = MediaQuery.of(context).size;
    // Size size = MediaQuery.of(context).size;
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 8,
                                      color: primaryColor.withOpacity(0.4),
                                    ),
                                  ],
                                  color: secondaryColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "$formattedDate",
                                          style: TextStyle(
                                              color: putih,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        StreamBuilder<DateTime>(
                                          stream: _streamController.stream,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              String formattedTime =
                                                  DateFormat('HH:mm:ss', 'id')
                                                      .format(snapshot.data!);
                                              return Text(
                                                formattedTime,
                                                style: TextStyle(
                                                    color: putih,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            } else {
                                              return Container(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 4,
                                                  strokeCap: StrokeCap.round,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(10),
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
                                  // print("Alamat dari Snapshot: ${snapshot.data}");
                                  return Text(
                                    '${snapshot.data}',
                                    style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print("Error: ${snapshot.error}");
                                  return Text("Error fetching address");
                                } else {
                                  return const Text('Loading...');
                                }
                              },
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
                      ));
                }
              },
            ),
            // SimpanPage(),
          ],
        ),
      ),
    );
  }
}

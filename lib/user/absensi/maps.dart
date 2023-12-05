// // ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

// ignore_for_file: unnecessary_new, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class SimpanPage extends StatefulWidget {
  const SimpanPage({Key? key}) : super(key: key);

  @override
  State<SimpanPage> createState() => _SimpanPageState();
}

class _SimpanPageState extends State<SimpanPage> {
  @override
  void initState() {
    super.initState();
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
    String formattedDate =
        "${tanggalHariIni.day}-${tanggalHariIni.month}-${tanggalHariIni.year}";
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<LocationData?>(
      future: _currenctLocation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final LocationData currentLocation = snapshot.data;
          // print("KODING : " +
          //     currentLocation.latitude.toString() +
          //     " | " +
          //     currentLocation.longitude.toString());
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.6,
                child: SfMaps(
                  layers: [
                    MapTileLayer(
                      initialFocalLatLng: MapLatLng(currentLocation.latitude!,
                          currentLocation.longitude!),
                      initialZoomLevel: 15, // Initial zoom level
                      initialMarkersCount: 1,
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "$formattedDate",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
          return Center(
            child: CircularProgressIndicator(),
          );
          // return Center(
          //   child: snapshot.hasError
          //       ? Text("Error: ${snapshot.error}")
          //       : Text("Error: ${snapshot.error}"),
          // );
        }
      },
    );
  }
}

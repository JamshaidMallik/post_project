import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  bool isLoading = true;
  Position? location;
  late LocationSettings locationSettings;
  List<Marker> markers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.8003214, 74.2607651),
      infoWindow: InfoWindow(title: 'My Office'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(31.8095, 74.2534),
      infoWindow: InfoWindow(title: 'Mujahid Hotel'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(31.8389, 74.2619),
      infoWindow: InfoWindow(title: 'Home'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
        );
      } else if (Platform.isIOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          showBackgroundLocationIndicator: false,
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }

      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Handle location service disabled
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        // Handle location permission denied forever
      }

      if (permission == LocationPermission.whileInUse) {
        location = await Geolocator.getLastKnownPosition();
        print("Positions $location");
        setState(() {
          isLoading = false;
        });
      }

      location = await Geolocator.getCurrentPosition();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handle any exceptions thrown during location determination
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(location!.latitude, location!.longitude),
            zoom: 13,
          ),
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(markers),
          buildingsEnabled: true,
          mapToolbarEnabled: true,
          polylines: {
            Polyline(
              polylineId: const PolylineId('1'),
              color: Colors.red,
              width: 3,
              jointType: JointType.round,
              consumeTapEvents: true,
              points: const [
                LatLng(31.8003214, 74.2607651),
                LatLng(31.8095, 74.2534),
                LatLng(31.8389, 74.2619),
              ],
            ),
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 35, top: 8),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          elevation: 1.0,
          isExtended: true,
          mini: true,
          onPressed: () async {
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(31.8389, 74.2619),
                zoom: 14.4746,
              ),
            ));
            setState(() {});
          },
          child: const Icon(Icons.location_searching),
        ),
      ),
    );
  }
}

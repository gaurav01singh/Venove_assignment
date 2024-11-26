import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng stopLocation;

  const RouteScreen({
    super.key,
    required this.startLocation,
    required this.stopLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Route from Start to Stop")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: startLocation,
          zoom: 12.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("start"),
            position: startLocation,
            infoWindow: const InfoWindow(title: "Start Location"),
          ),
          Marker(
            markerId: const MarkerId("stop"),
            position: stopLocation,
            infoWindow: const InfoWindow(title: "Stop Location"),
          ),
        },
      ),
    );
  }
}
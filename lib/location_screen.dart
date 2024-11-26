import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location123/member.dart'; // Assuming member class is in this file

class LocationScreen extends StatelessWidget {
  final Member member;

  LocationScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      // Red marker for the current location
      Marker(
        markerId: MarkerId('current_location'),
        position: member.currentLocation,
        infoWindow: InfoWindow(title: 'Current Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };

    // Green markers for each visited location
    for (var visitedLocation in member.visitedLocations) {
      markers.add(
        Marker(
          markerId: MarkerId(visitedLocation.location.toString()),
          position: visitedLocation.location,
          infoWindow: InfoWindow(title: 'Visited Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(member.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: member.currentLocation,
                zoom: 14,
              ),
              markers: markers,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visited Locations:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                // List of visited locations
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: member.visitedLocations.length,
                  itemBuilder: (context, index) {
                    final visitedLocation = member.visitedLocations[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        title: Text(
                          'Location: ${visitedLocation.location.latitude}, ${visitedLocation.location.longitude}',
                        ),
                        subtitle: Text(
                          'Visited at: ${visitedLocation.visitTime}',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

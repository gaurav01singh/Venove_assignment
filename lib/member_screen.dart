import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import 'member.dart'; // Your Member model file

class MemberScreen extends StatelessWidget {
  final Member member;

  const MemberScreen({super.key, required this.member});

  // Method to format DateTime for display
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  // Method to get the nearest landmark or address using geocoding
  Future<String> _getAddressFromLatLng(LatLng position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      // Combining address components (e.g., city, country, etc.)
      return '${place.name}, ${place.locality}, ${place.country}';
    } else {
      return 'No address found';
    }
  } catch (e) {
    return 'Error retrieving address';
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${member.name} - Locations'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: member.currentLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('${member.name}_current'),
                  position: member.currentLocation,
                  infoWindow: const InfoWindow(
                    title: 'Current Location',
                  ),
                ),
                ...member.visitedLocations.map((visitedLocation) {
                  return Marker(
                    markerId: MarkerId('${member.name}_visited_${visitedLocation.location.latitude}_${visitedLocation.location.longitude}'),
                    position: visitedLocation.location,
                    infoWindow: InfoWindow(
                      title: 'Visited Location',
                      snippet: 'Visited at ${_formatDateTime(visitedLocation.visitTime)}',
                    ),
                  );
                }).toSet(),
              },
            ),
          ),
          
          // Display visited locations list at the bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Visited Locations: ${member.visitedLocations.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // Visited locations list
          Expanded(
            child: ListView.builder(
              itemCount: member.visitedLocations.length,
              itemBuilder: (context, index) {
                final visitedLocation = member.visitedLocations[index];
                return FutureBuilder<String>(
                  future: _getAddressFromLatLng(visitedLocation.location),
                  builder: (context, snapshot) {
                    String address = 'Loading address...';
                    if (snapshot.connectionState == ConnectionState.done) {
                      address = snapshot.data ?? 'Address not found';
                    }

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(
                          _formatDateTime(visitedLocation.visitTime),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Location: $address'),
                        trailing: const Icon(Icons.location_on, color: Colors.blueAccent),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

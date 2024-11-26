import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location123/attendance_screen.dart';
import 'package:location123/member.dart';
import 'package:location123/member_screen.dart'; // Import the MemberScreen

class HomeScreen extends StatefulWidget {
  final LatLng selectedLocation;
  final List<Member> members;

  const HomeScreen({super.key, required this.selectedLocation, required this.members});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _mapController;

  // Method to add markers for all members
  Set<Marker> _createMarkers() {
    return widget.members.map((member) {
      return Marker(
        markerId: MarkerId(member.name),
        position: member.currentLocation,
        infoWindow: InfoWindow(
          title: member.name,
        ),
        onTap: () {
          // Navigate to MemberScreen when the marker is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberScreen(member: member), // Pass member to MemberScreen
            ),
          );
        },
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Example'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ...widget.members.map((member) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(
                    member.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.location_on, color: Colors.blueAccent),
                        onPressed: () {
                          // Navigate to this member's location on the map
                          Navigator.pop(context); // Close the drawer first
                          _mapController.animateCamera(
                            CameraUpdate.newLatLng(member.currentLocation),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          // Navigate to AttendanceScreen (optional)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceScreen(member: member),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            // ignore: unnecessary_to_list_in_spreads
            }).toList(),
          ],
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.selectedLocation,
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: _createMarkers(), // Set the markers for all members
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}

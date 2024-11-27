import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location123/member.dart';
import 'package:location123/route_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart'; // Assuming member class is in this file

class LocationScreen extends StatefulWidget {
  final Member member;

  const LocationScreen({super.key, required this.member});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<String> visitedLocationNames = [];

  @override
  void initState() {
    super.initState();
    _fetchVisitedLocationNames();
  }

  // Fetch addresses for visited locations
  Future<void> _fetchVisitedLocationNames() async {
    List<String> locationNames = [];
    for (var visitedLocation in widget.member.visitedLocations) {
      String address = await _getAddressFromLatLng(
        visitedLocation.location.latitude,
        visitedLocation.location.longitude,
      );
      locationNames.add(address);
    }
    setState(() {
      visitedLocationNames = locationNames;
    });
  }

  // Reverse geocoding function
  Future<String> _getAddressFromLatLng(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      }
    } catch (e) {
      print('Error during reverse geocoding: $e');
    }
    return 'Unknown Location';
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('current_location'),
        position: widget.member.currentLocation,
        infoWindow: InfoWindow(
          title: widget.member.status == 'WORKING'
              ? 'Current Location'
              : 'Last Location',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };

    String formattedDate =
        DateFormat('EEE, MMM d, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('TRACK LIVE LOCATION'),
        backgroundColor: Colors.purple,
      ),
      body: SlidingUpPanel(
        panel: _buildVisitedLocationsPanel(formattedDate),
        body: _buildMap(markers),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        minHeight: 150,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
    );
  }

  // Map widget
  Widget _buildMap(Set<Marker> markers) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.member.currentLocation,
        zoom: 14,
      ),
      markers: markers,
    );
  }

  // Visited Locations Panel
  Widget _buildVisitedLocationsPanel(String formattedDate) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Member details
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(widget.member.imageUrl),
                backgroundColor: Colors.grey,
                child: widget.member.imageUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.member.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.member.status,
                    style: TextStyle(
                      color: widget.member.status == 'NOT LOGGED-IN'
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.member.status != 'NOT LOGGED-IN') ...[
                    const Row(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text('09:30 AM'),
                      ],
                    ),
                    if (widget.member.status != 'WORKING') ...[
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.arrow_downward,
                              color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text('06:40 PM'),
                        ],
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.purple),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Sites: 10', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(formattedDate, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          // List of visited locations
          Expanded(
            child: ListView.builder(
              itemCount: widget.member.visitedLocations.length,
              itemBuilder: (context, index) {
                final visitedLocation = widget.member.visitedLocations[index];
                final locationName = visitedLocationNames.isNotEmpty &&
                        index < visitedLocationNames.length
                    ? visitedLocationNames[index]
                    : 'Fetching...';
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.purple),
                  title: Text(
                    locationName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    'Arrival: ${DateFormat('hh:mm a').format(visitedLocation.arrivalTime)}\n'
                    'Leave: ${DateFormat('hh:mm a').format(visitedLocation.leaveTime)}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    if (index >= 0) {
                      // Navigate to RouteScreen with start and end locations
                      final previousLocation =
                          widget.member.visitedLocations[index+1].location;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteScreen(
                            startLocation: LatLng(previousLocation.latitude,
                                previousLocation.longitude),
                            endLocation: LatLng(
                                visitedLocation.location.latitude,
                                visitedLocation.location.longitude), memberName: widget.member.name, memberImageUrl: widget.member.imageUrl,
                          ),
                        ),
                      );
                    } else {
                      // Show a message if there's no previous location
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'No previous location to show the route.')),
                      );
                    }
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

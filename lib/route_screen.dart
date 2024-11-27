import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';

class RouteScreen extends StatefulWidget {
  final String memberName;
  final String memberImageUrl; // Added member image URL
  final LatLng startLocation;
  final LatLng endLocation;

  const RouteScreen({
    super.key,
    required this.memberName,
    required this.memberImageUrl,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  Set<Polyline> _polylines = {};
  double _totalDistance = 0.0; // Total distance in kilometers
  String _duration = ''; // Total time taken
  String _startPlaceName = '';
  String _endPlaceName = '';

  @override
  void initState() {
    super.initState();
    _fetchRoute();
    _fetchPlaceNames();
  }

  Future<void> _fetchPlaceNames() async {
    try {
      // Reverse geocoding for start location
      List<Placemark> startPlacemarks = await placemarkFromCoordinates(
        widget.startLocation.latitude,
        widget.startLocation.longitude,
      );
      // Reverse geocoding for end location
      List<Placemark> endPlacemarks = await placemarkFromCoordinates(
        widget.endLocation.latitude,
        widget.endLocation.longitude,
      );

      if (startPlacemarks.isNotEmpty && endPlacemarks.isNotEmpty) {
        final startPlacemark = startPlacemarks.first;
        final endPlacemark = endPlacemarks.first;

        setState(() {
          // Constructing full addresses
          _startPlaceName = '${startPlacemark.name}, ${startPlacemark.street}, '
              '${startPlacemark.locality}, ${startPlacemark.postalCode}, ${startPlacemark.country}';

          _endPlaceName = '${endPlacemark.name}, ${endPlacemark.street}, '
              '${endPlacemark.locality}, ${endPlacemark.postalCode}, ${endPlacemark.country}';
        });
      }
    } catch (e) {
      print('Error getting place names: $e');
    }
  }

  Future<void> _fetchRoute() async {
    const apiKey = 'your_api_key';
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?'
      'origin=${widget.startLocation.latitude},${widget.startLocation.longitude}&'
      'destination=${widget.endLocation.latitude},${widget.endLocation.longitude}&'
      'mode=driving&key=$apiKey',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (response.statusCode == 200 && (data['routes'] as List).isNotEmpty) {
        final route = data['routes'][0];
        final polylinePoints = route['overview_polyline']['points'];
        final polylineCoordinates = _decodePolyline(polylinePoints);

        setState(() {
          _polylines = {
            Polyline(
              polylineId: const PolylineId('route'),
              color: Colors.blue,
              width: 5,
              points: polylineCoordinates,
            ),
          };
          _totalDistance = route['legs'][0]['distance']['value'] /
              1000; // Convert meters to kilometers
          _duration =
              route['legs'][0]['duration']['text']; // Human-readable duration
        });
      } else {
        _showError('No route found.');
      }
    } catch (e) {
      _showError('Error fetching route: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dLat;

      shift = 0;
      result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Details'),
        backgroundColor: const Color.fromARGB(255, 64, 39, 176),
      ),
      body: Column(
        children: [
          // Member Details and Route Summary
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Member Image and Name
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(widget.memberImageUrl),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.memberName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(
                      color: Colors.grey, 
                      thickness: 1.0,
                      height: 16.0, 
                    ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Starting point details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        const Text(
                          'Starting Point: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            _startPlaceName.isNotEmpty
                                ? _startPlaceName
                                : 'Loading...',
                            style: const TextStyle(color: Colors.grey),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey, 
                      thickness: 1.0,
                      height: 16.0, 
                    ),
                    // Ending point details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        const Text(
                          'Ending Point: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            _endPlaceName.isNotEmpty
                                ? _endPlaceName
                                : 'Loading...',
                            style: const TextStyle(color: Colors.grey),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                      color: Colors.grey, 
                      thickness: 1.0,
                      height: 16.0, 
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Distance: ${_totalDistance.toStringAsFixed(2)} km',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                Text(
                  'Time Taken: $_duration',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),
          // Map Widget
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.startLocation,
                zoom: 12,
              ),
              polylines: _polylines,
              markers: {
                Marker(
                  markerId: const MarkerId('start'),
                  position: widget.startLocation,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen), // Set the marker to green
                  infoWindow: const InfoWindow(title: 'Starting Point'),
                ),
                Marker(
                  markerId: const MarkerId('end'),
                  position: widget.endLocation,
                  infoWindow: const InfoWindow(title: 'Ending Point'),
                ),
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Member {
  final String id; // Unique identifier for the member
  final String name; // Member's name
  final LatLng currentLocation; // The current location of the member
  final List<VisitedLocation> visitedLocations; 
  final String status; // Status (e.g., WORKING, NOT LOGGED-IN)
  final String imageUrl; // Profile picture URL

  // Constructor with required parameters
  Member({
    required this.id,
    required this.name,
    required this.currentLocation,
    required this.visitedLocations,
    required this.status,
    required this.imageUrl,
  });
}

class VisitedLocation {
  final LatLng location; // Location coordinates
  final DateTime visitTime; // Date and time of the visit
  final DateTime arrivalTime; // Date and time of arrival
  final DateTime leaveTime; // Date and time of leave

  VisitedLocation({
    required this.location,
    required this.visitTime,
    required this.arrivalTime,
    required this.leaveTime,
  });
}



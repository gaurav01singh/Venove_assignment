import 'package:google_maps_flutter/google_maps_flutter.dart';

class Member {
  final String id; // Unique identifier for the member
  final String name; // Member's name
  final LatLng currentLocation; // The current location of the member
  final List<VisitedLocation> visitedLocations; // List of visited locations
  late final List<AttendanceRecord> attendanceRecords; // List of attendance records
  final String status; // Status (e.g., WORKING, NOT LOGGED-IN)
  final String imageUrl; // Profile picture URL

  // Constructor with required parameters
  Member({
    required this.id,
    required this.name,
    required this.currentLocation,
    required this.visitedLocations,
    required this.attendanceRecords,
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

class AttendanceRecord {
  late final DateTime checkInTime; // Time of check-in
  late final DateTime? checkOutTime; // Time of check-out (nullable)
  final bool isPresent; // Attendance status

  AttendanceRecord({
    required this.checkInTime,
    this.checkOutTime,
    required this.isPresent,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'isPresent': isPresent,
    };
  }

  // Create from JSON
  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      checkInTime: DateTime.parse(json['checkInTime']),
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'])
          : null,
      isPresent: json['isPresent'],
    );
  }
}

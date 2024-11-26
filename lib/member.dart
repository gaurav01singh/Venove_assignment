import 'package:google_maps_flutter/google_maps_flutter.dart';

class Member {
  final String id; // Unique identifier for the member
  final String name; // Member's name
  final LatLng currentLocation; // The current location of the member
  final List<VisitedLocation> visitedLocations; // List of visited locations
  late final List<AttendanceRecord> attendanceRecords; // List of attendance records

  // Constructor with required parameters
  Member({
    required this.id,
    required this.name,
    required this.currentLocation,
    required this.visitedLocations,
    required this.attendanceRecords,
  });
}

// Model for a visited location
class VisitedLocation {
  final LatLng location; // Location coordinates
  final DateTime visitTime; // Date and time of the visit

  // Constructor with required parameters
  VisitedLocation({
    required this.location,
    required this.visitTime,
  });
}

// Model for an attendance record
class AttendanceRecord {
  DateTime checkInTime;
  DateTime? checkOutTime;
  bool isPresent;

  AttendanceRecord({
    required this.checkInTime,
    this.checkOutTime,
    required this.isPresent,
  });

  // Convert AttendanceRecord to JSON
  Map<String, dynamic> toJson() {
    return {
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'isPresent': isPresent,
    };
  }

  // Create AttendanceRecord from JSON
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


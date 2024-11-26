import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location123/homescreen.dart';
import 'package:location123/member.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create some dummy member data
    List<Member> members = [
  Member(
    id: '1',
    name: "SHIFA SHEIKH",
    currentLocation: const LatLng(28.6692, 77.4538), // Near Ghaziabad
    visitedLocations: [
      VisitedLocation(
        location: const LatLng(28.6612, 77.4521),
        visitTime: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      VisitedLocation(
        location: const LatLng(28.6675, 77.4445),
        visitTime: DateTime.now().subtract(const Duration(days: 1)),
      ),
      VisitedLocation(
        location: const LatLng(28.6533, 77.4310),
        visitTime: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ],
    attendanceRecords: [
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 1)),
        isPresent: true,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 2)),
        isPresent: false,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 3)),
        isPresent: false,
      ),
    ],
  ),
  Member(
    id: '2',
    name: "SUSEN JAYSWAL",
    currentLocation: const LatLng(28.6785, 77.4876), // Ghaziabad
    visitedLocations: [
      VisitedLocation(
        location: const LatLng(28.6721, 77.4800),
        visitTime: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      VisitedLocation(
        location: const LatLng(28.6885, 77.4945),
        visitTime: DateTime.now().subtract(const Duration(days: 2)),
      ),
      VisitedLocation(
        location: const LatLng(28.6740, 77.4680),
        visitTime: DateTime.now().subtract(const Duration(days: 4)),
      ),
    ],
    attendanceRecords: [
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 1)),
        isPresent: true,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 2)),
        isPresent: true,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 3)),
        isPresent: false,
      ),
    ],
  ),
  Member(
    id: '3',
    name: "ADARSH GUPTA",
    currentLocation: const LatLng(28.6589, 77.3695), // Near Ghaziabad
    visitedLocations: [
      VisitedLocation(
        location: const LatLng(28.6485, 77.3710),
        visitTime: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      VisitedLocation(
        location: const LatLng(28.6307, 77.3560),
        visitTime: DateTime.now().subtract(const Duration(days: 1)),
      ),
      VisitedLocation(
        location: const LatLng(28.6722, 77.3876),
        visitTime: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ],
    attendanceRecords: [
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 1)),
        isPresent: true,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 3)),
        isPresent: false,
      ),
    ],
  ),
  Member(
    id: '4',
    name: "RAVI KUMAR",
    currentLocation: const LatLng(28.6415, 77.3792), // Ghaziabad
    visitedLocations: [
      VisitedLocation(
        location: const LatLng(28.6278, 77.3835),
        visitTime: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      VisitedLocation(
        location: const LatLng(28.6293, 77.3908),
        visitTime: DateTime.now().subtract(const Duration(days: 2)),
      ),
      VisitedLocation(
        location: const LatLng(28.6371, 77.3760),
        visitTime: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ],
    attendanceRecords: [
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 1)),
        isPresent: false,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 2)),
        isPresent: true,
      ),
    ],
  ),
  Member(
    id: '5',
    name: "PRIYA SHARMA",
    currentLocation: const LatLng(28.6430, 77.3708), // Near Ghaziabad
    visitedLocations: [
      VisitedLocation(
        location: const LatLng(28.6331, 77.3664),
        visitTime: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      VisitedLocation(
        location: const LatLng(28.6255, 77.3588),
        visitTime: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ],
    attendanceRecords: [
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 1)),
        isPresent: true,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 4)),
        isPresent: true,
      ),
    ],
  ),
  Member(
    id: '6',
    name: "AKASH VERMA",
    currentLocation: const LatLng(28.6505, 77.3998), // Near Ghaziabad
    visitedLocations: [
      VisitedLocation(
        location: const LatLng(28.6405, 77.4010),
        visitTime: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ],
    attendanceRecords: [
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 2)),
        isPresent: true,
      ),
      AttendanceRecord(
        checkInTime: DateTime.now().subtract(const Duration(days: 5)),
        isPresent: false,
      ),
    ],
  ),
];


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(
        selectedLocation: members[0]
            .currentLocation, // Pass the first member's location as selectedLocation
        members: members, // Pass the member list
      ),
    );
  }
}

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
        currentLocation: const LatLng(28.6692, 77.4538), // Ghaziabad
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.6712, 77.4521),
            visitTime: DateTime.now().subtract(const Duration(hours: 1)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.6675, 77.4445),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.6533, 77.4310),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "WORKING",
        imageUrl: "lib/assets/image/shifa_sheikh.jpg",
      ),
      Member(
        id: '2',
        name: "RAHUL KUMAR",
        currentLocation: const LatLng(28.5244, 77.1855), // South Delhi
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.5230, 77.1840),
            visitTime: DateTime.now().subtract(const Duration(hours: 2)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.5290, 77.1820),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.5300, 77.1900),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "WORKING",
        imageUrl: "lib/assets/image/RAHUL KUMAR.jpg",
      ),
      Member(
        id: '3',
        name: "PRIYA AGARWAL",
        currentLocation: const LatLng(28.5921, 77.0460), // Dwarka
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.5900, 77.0440),
            visitTime: DateTime.now().subtract(const Duration(hours: 3)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.5920, 77.0450),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.5950, 77.0470),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "checked out",
        imageUrl: "lib/assets/image/PRIYA AGARWAL.jpg",
      ),
      Member(
        id: '4',
        name: "AMAN VERMA",
        currentLocation: const LatLng(28.4595, 77.0266), // Gurgaon
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.4600, 77.0250),
            visitTime: DateTime.now().subtract(const Duration(hours: 4)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.4580, 77.0280),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.4540, 77.0300),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "NOT LOGGED-IN",
        imageUrl: "lib/assets/image/AMAN_VERMA.jpg",
      ),
      Member(
        id: '5',
        name: "ANJALI SINGH",
        currentLocation: const LatLng(28.6129, 77.2295), // Central Delhi
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.6130, 77.2080),
            visitTime: DateTime.now().subtract(const Duration(hours: 5)),
            arrivalTime: DateTime(2024, 11, 26, 8, 0),
            leaveTime: DateTime(2024, 11, 26, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.6140, 77.2100),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2024, 11, 26, 9, 30),
            leaveTime: DateTime(2024, 11, 26, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.6160, 77.2110),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2024, 11, 26, 11, 0),
            leaveTime: DateTime(2024, 11, 26, 12, 0),
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
        status: "checked out",
        imageUrl: "lib/assets/image/ANJALI SINGH.jpg",
      ),
      Member(
        id: '6',
        name: "VIKAS SHARMA",
        currentLocation: const LatLng(28.9845, 77.7064), // Meerut
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.9830, 77.7050),
            visitTime: DateTime.now().subtract(const Duration(hours: 1)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.9850, 77.7070),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.9870, 77.7080),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "checked out",
        imageUrl: "lib/assets/image/VIKAS SHARMA.jpg",
      ),
      Member(
        id: '7',
        name: "ANKITA GUPTA",
        currentLocation: const LatLng(28.6304, 77.4416), // Noida Sector 62
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.6300, 77.4400),
            visitTime: DateTime.now().subtract(const Duration(hours: 1)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.6320, 77.4430),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.6350, 77.4450),
            visitTime: DateTime.now().subtract(const Duration(days: 2)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "WORKING",
        imageUrl: "lib/assets/image/ANKITA GUPTA.jpg",
      ),
      Member(
        id: '8',
        name: "RAJESH VERMA",
        currentLocation: const LatLng(28.4089, 77.3178), // Faridabad
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.4080, 77.3160),
            visitTime: DateTime.now().subtract(const Duration(hours: 2)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.4090, 77.3180),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.4100, 77.3200),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "NOT LOGGED-IN",
        imageUrl: "lib/assets/image/RAJESH VERMA.jpg",
      ),
      Member(
        id: '9',
        name: "SUNITA RANA",
        currentLocation: const LatLng(28.7041, 77.1025), // North Delhi
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.7030, 77.1000),
            visitTime: DateTime.now().subtract(const Duration(hours: 2)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.7090, 77.1020),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.7100, 77.1100),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "checked out",
        imageUrl: "lib/assets/image/SUNITA RANA.jpg",
      ),
      Member(
        id: '10',
        name: "RAKESH MALHOTRA",
        currentLocation: const LatLng(28.6857, 77.2217), // Civil Lines
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.6850, 77.2200),
            visitTime: DateTime.now().subtract(const Duration(hours: 4)),
            arrivalTime: DateTime(2024, 11, 26, 8, 0),
            leaveTime: DateTime(2024, 11, 26, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.6860, 77.2220),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2024, 11, 26, 9, 30),
            leaveTime: DateTime(2024, 11, 26, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.6870, 77.2230),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2024, 11, 26, 11, 0),
            leaveTime: DateTime(2024, 11, 26, 12, 0),
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
        status: "WORKING",
        imageUrl: "lib/assets/image/RAKESH MALHOTRA.jpg",
      ),
      Member(
        id: '11',
        name: "MANISHA SINGH",
        currentLocation: const LatLng(28.5708, 77.3219), // Noida Sector 18
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.5700, 77.3200),
            visitTime: DateTime.now().subtract(const Duration(hours: 1)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.5720, 77.3230),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.5750, 77.3250),
            visitTime: DateTime.now().subtract(const Duration(days: 2)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "WORKING",
        imageUrl: "lib/assets/image/shifa_sheikh.jpg",
      ),
      Member(
        id: '12',
        name: "ANIL KHANNA",
        currentLocation: const LatLng(28.6162, 77.2861), // East Delhi
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.6160, 77.2850),
            visitTime: DateTime.now().subtract(const Duration(hours: 2)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.6170, 77.2870),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.6180, 77.2890),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "NOT LOGGED-IN",
        imageUrl: "lib/assets/image/ANIL KHANNA.jpg",
      ),
      Member(
        id: '13',
        name: "PANKAJ JAIN",
        currentLocation: const LatLng(28.4808, 77.0644), // Gurgaon Sector 29
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.4800, 77.0630),
            visitTime: DateTime.now().subtract(const Duration(hours: 3)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.4820, 77.0650),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.4850, 77.0670),
            visitTime: DateTime.now().subtract(const Duration(days: 2)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "NOT LOGGED-IN",
        imageUrl: "lib/assets/image/PANKAJ JAIN.jpg",
      ),
      Member(
        id: '14',
        name: "PRIYA SHARMA",
        currentLocation: const LatLng(28.6348, 77.1154), // West Delhi
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.6340, 77.1140),
            visitTime: DateTime.now().subtract(const Duration(hours: 4)),
            arrivalTime: DateTime(2024, 11, 26, 8, 0),
            leaveTime: DateTime(2024, 11, 26, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.6140, 77.2100),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2024, 11, 26, 9, 30),
            leaveTime: DateTime(2024, 11, 26, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.6160, 77.2110),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2024, 11, 26, 11, 0),
            leaveTime: DateTime(2024, 11, 26, 12, 0),
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
        status: "checked out",
        imageUrl: "lib/assets/image/PRIYA SHARMA.jpg",
      ),
      Member(
        id: '15',
        name: "ANKUR SINGH",
        currentLocation: const LatLng(28.7041, 77.1025), // Near Delhi
        visitedLocations: [
          VisitedLocation(
            location: const LatLng(28.7030, 77.1000),
            visitTime: DateTime.now().subtract(const Duration(hours: 2)),
            arrivalTime: DateTime(2022, 8, 31, 8, 0),
            leaveTime: DateTime(2022, 8, 31, 9, 0),
          ),
          VisitedLocation(
            location: const LatLng(28.7090, 77.1020),
            visitTime: DateTime.now().subtract(const Duration(days: 1)),
            arrivalTime: DateTime(2022, 8, 31, 9, 30),
            leaveTime: DateTime(2022, 8, 31, 10, 30),
          ),
          VisitedLocation(
            location: const LatLng(28.7100, 77.1100),
            visitTime: DateTime.now().subtract(const Duration(days: 3)),
            arrivalTime: DateTime(2022, 8, 31, 11, 0),
            leaveTime: DateTime(2022, 8, 31, 12, 0),
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
        status: "NOT LOGGED-IN",
        imageUrl: "lib/assets/image/ANKUR SINGH.jpg",
      ),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(
        members: members,
      ),
    );
  }
}
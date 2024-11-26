import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding data

import 'member.dart';

class AttendanceScreen extends StatefulWidget {
  final Member member;

  const AttendanceScreen({super.key, required this.member});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Method to format DateTime for display
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  // Function to calculate attendance percentage
  double _calculateAttendancePercentage() {
    int totalDays = 30; // Example: Total days to consider for percentage
    int presentDays = widget.member.attendanceRecords
        .where((record) => record.checkOutTime != null) // Count days with both check-in and check-out
        .length;

    return (presentDays / totalDays) * 100;  // Calculate percentage
  }

  @override
  void initState() {
    super.initState();
    _loadAttendanceData();
  }

  // Load attendance records from SharedPreferences
  Future<void> _loadAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = widget.member.id;

    // Fetch saved attendance records for the member
    final savedData = prefs.getString('attendance_$memberId');
    if (savedData != null) {
      final List<dynamic> jsonData = jsonDecode(savedData);
      setState(() {
        widget.member.attendanceRecords = jsonData
            .map((item) => AttendanceRecord.fromJson(item))
            .toList();

        // Mark previous day's attendance as checked out if not done already
        _markPreviousRecordsAsCheckedOut();
      });
    }
  }

  // Save attendance records to SharedPreferences
  Future<void> _saveAttendanceData() async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = widget.member.id;

    final jsonData = jsonEncode(
      widget.member.attendanceRecords
          .map((item) => item.toJson())
          .toList(),
    );

    await prefs.setString('attendance_$memberId', jsonData);
  }

  // Mark previous records (without check-out) as checked out
  void _markPreviousRecordsAsCheckedOut() {
    final now = DateTime.now();

    for (var record in widget.member.attendanceRecords) {
      // If the record does not have a check-out time and it's from a previous date
      if (record.checkOutTime == null &&
          (record.checkInTime.year < now.year ||
          (record.checkInTime.year == now.year &&
              record.checkInTime.month < now.month) ||
          (record.checkInTime.year == now.year &&
              record.checkInTime.month == now.month &&
              record.checkInTime.day < now.day))) {
        
        // Set specific times for check-in and check-out
        DateTime checkInTime = DateTime(
          record.checkInTime.year,
          record.checkInTime.month,
          record.checkInTime.day,
          9, 10, 0, 0, 0, // Set check-in to 9:10 AM
        );

        DateTime checkOutTime = DateTime(
          record.checkInTime.year,
          record.checkInTime.month,
          record.checkInTime.day,
          18, 0, 0, 0, 0, // Set check-out to 6:00 PM
        );

        // Assign the specific check-in and check-out times
        record.checkInTime = checkInTime;
        record.checkOutTime = checkOutTime;
      }
    }
    _saveAttendanceData(); // Save the updated attendance records
  }

  @override
  Widget build(BuildContext context) {
    double attendancePercentage = _calculateAttendancePercentage();

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance for ${widget.member.name}'),
      ),
      body: Column(
        children: [
          // Display attendance percentage
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Attendance Percentage: ${attendancePercentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.member.attendanceRecords.length,
              itemBuilder: (context, index) {
                final record = widget.member.attendanceRecords[index];
                return ListTile(
                  title: Text('Check-in: ${_formatDateTime(record.checkInTime)}'),
                  subtitle: record.checkOutTime != null
                      ? Text('Check-out: ${_formatDateTime(record.checkOutTime!)}')
                      : const Text('Still checked in'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleAttendance(context);
        },
        tooltip: 'Add Attendance',
        child: const Icon(Icons.check),
      ),
    );
  }

  // Method to handle check-in/check-out toggle
  void _handleAttendance(BuildContext context) {
    final now = DateTime.now();

    // Check if there's an active check-in record for today
    bool hasActiveCheckIn = widget.member.attendanceRecords.any((record) =>
        record.checkInTime.year == now.year &&
        record.checkInTime.month == now.month &&
        record.checkInTime.day == now.day &&
        record.checkOutTime == null);

    // If there's already an active check-in, we mark it as checked out
    if (hasActiveCheckIn) {
      setState(() {
        widget.member.attendanceRecords.last.checkOutTime = now; // Mark check-out
      });
      _saveAttendanceData(); // Save updated attendance records
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Checked out!')));
    } else {
      // If no active check-in exists, create a new check-in
      setState(() {
        widget.member.attendanceRecords.add(AttendanceRecord(
          checkInTime: now,
          isPresent: true, // Add the required isPresent parameter
        ));
      });
      _saveAttendanceData(); // Save updated attendance records
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Checked in!')));
    }
  }
}

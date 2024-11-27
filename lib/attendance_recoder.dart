class AttendanceRecord {
  final DateTime checkInTime;
  DateTime? checkOutTime; // Nullable to handle cases without check-out.

  AttendanceRecord({
    required this.checkInTime,
    this.checkOutTime,
  });
}

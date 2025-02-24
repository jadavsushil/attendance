import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<AttendanceResponseEntity> getAttendance(Map<String, dynamic> jsonData);
}

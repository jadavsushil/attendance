import 'package:attendence_app/domain/entities/attendance.dart';
import 'package:attendence_app/domain/repositories/attendance_repository.dart';

class GetAttendace {
  final AttendanceRepository repository;

  GetAttendace({required this.repository});

  Future<AttendanceResponseEntity> execute(
      Map<String, dynamic> jsonData) async {
    return await repository.getAttendance(jsonData);
  }
}

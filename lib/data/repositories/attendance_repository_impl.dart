import 'package:attendence_app/data/datasource/attendance_remote_data_source.dart';
import 'package:attendence_app/data/model/attendance_model.dart';
import 'package:attendence_app/domain/entities/attendance.dart';
import 'package:attendence_app/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource dataSource;
  AttendanceRepositoryImpl({required this.dataSource});

  @override
  Future<AttendanceResponseEntity> getAttendance(
      Map<String, dynamic> jsonData) async {
    final results = await dataSource.getAttendance(jsonData);

    final data = results['data'];

    return AttendanceResponse.fromJson(data).toEntity();
  }
}

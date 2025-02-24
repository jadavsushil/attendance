import 'package:attendence_app/data/repositories/attendance_repository_impl.dart';
import 'package:attendence_app/domain/usecases/get_attendace.dart';
import 'package:attendence_app/presentation/controllers/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/datasource/attendance_remote_data_source.dart';
import 'presentation/pages/attendance/attendance_analitics.dart';

void main() {
  Get.put(AttendanceController(
      getAttendance: GetAttendace(
          repository: AttendanceRepositoryImpl(
              dataSource: AttendanceRemoteDataSource()))));
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, home: AttendanceAnalitics()));
}

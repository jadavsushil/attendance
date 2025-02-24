import 'package:attendence_app/data/datasource/app_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceRemoteDataSource {
  Future getAttendance(Map<String, dynamic> jsonData) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstant.baseUrl}${AppConstant.getAttendance}'),
        headers: {"Content-Type": "application/json"},
        // body: json.encode(jsonData),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch attendance data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

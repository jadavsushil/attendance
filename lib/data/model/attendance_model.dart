import 'package:attendence_app/domain/entities/attendance.dart';

class AttendanceResponse {
  final List<TabFilter> tabFilter;
  final List<GroupData> groupData;
  final List<AttendanceData> daily;
  final List<AttendanceData> weekly;

  AttendanceResponse({
    required this.tabFilter,
    required this.groupData,
    required this.daily,
    required this.weekly,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      tabFilter: (json['tabFilter'] as List<dynamic>?)
              ?.map((e) => TabFilter.fromJson(e))
              .toList() ??
          [],
      groupData: (json['groupData'] as List<dynamic>?)
              ?.map((e) => GroupData.fromJson(e))
              .toList() ??
          [],
      daily: (json['daily'] as List<dynamic>?)
              ?.map((e) => AttendanceData.fromJson(e))
              .toList() ??
          [],
      weekly: (json['weekly'] as List<dynamic>?)
              ?.map((e) => AttendanceData.fromJson(e))
              .toList() ??
          [],
    );
  }

  AttendanceResponseEntity toEntity() {
    return AttendanceResponseEntity(
      tabFilter: tabFilter.map((e) => e.toEntity()).toList(),
      groupData: groupData.map((e) => e.toEntity()).toList(),
      daily: daily.map((e) => e.toEntity()).toList(),
      weekly: weekly.map((e) => e.toEntity()).toList(),
    );
  }
}

class TabFilter {
  final String id;
  final String title;
  final String type;
  final List<POSData>? data; // Only applicable if type == "pos"

  TabFilter({
    required this.id,
    required this.title,
    required this.type,
    this.data,
  });

  factory TabFilter.fromJson(Map<String, dynamic> json) {
    return TabFilter(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      data: json.containsKey('data') && json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((e) => POSData.fromJson(e))
              .toList()
          : null, // Handle null case for "date" and "group"
    );
  }

  TabFilterEntity toEntity() {
    return TabFilterEntity(
      id: id,
      title: title,
      type: type,
      data: data?.map((e) => e.toEntity()).toList(),
    );
  }
}

class POSData {
  final String id;
  final String title;

  POSData({required this.id, required this.title});

  factory POSData.fromJson(Map<String, dynamic> json) {
    return POSData(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
    );
  }

  POSEntity toEntity() {
    return POSEntity(id: id, title: title);
  }
}

class GroupData {
  final int id;
  final String title;
  final String color;

  GroupData({required this.id, required this.title, required this.color});

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      color: json['color'] ?? '',
    );
  }

  GroupEntity toEntity() {
    return GroupEntity(id: id, title: title, color: color);
  }
}

class AttendanceData {
  final String date;
  final List<int> values;
  final List<String> colors;
  final String? average;

  AttendanceData({
    required this.date,
    required this.values,
    required this.colors,
    this.average,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      date: json['date'] ?? '',
      values:
          (json['values'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              [],
      colors: (json['colors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      average: json['average'] ?? '',
    );
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      date: date,
      values: values,
      colors: colors,
      average: average,
    );
  }
}

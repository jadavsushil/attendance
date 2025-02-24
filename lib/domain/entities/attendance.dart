class AttendanceResponseEntity {
  List<GroupEntity> groupData;
  List<AttendanceEntity> daily;
  List<AttendanceEntity> weekly;
  List<TabFilterEntity> tabFilter; // Updated to use entity

  AttendanceResponseEntity({
    required this.groupData,
    required this.daily,
    required this.weekly,
    required this.tabFilter,
  });
}

class GroupEntity {
  final int id;
  final String title;
  final String color;

  GroupEntity({
    required this.id,
    required this.title,
    required this.color,
  });
}

class AttendanceEntity {
  final String date;
  final String? average;
  final List<int> values;
  final List<String> colors;

  AttendanceEntity({
    required this.date,
    required this.values,
    required this.colors,
    this.average,
  });
}

class TabFilterEntity {
  final String id;
  final String title;
  final String type;
  final List<POSEntity>? data;

  TabFilterEntity({
    required this.id,
    required this.title,
    required this.type,
    this.data,
  });
}

class POSEntity {
  final String id;
  final String title;

  POSEntity({required this.id, required this.title});
}

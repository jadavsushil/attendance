import 'package:attendence_app/domain/entities/attendance.dart';
import 'package:attendence_app/domain/usecases/get_attendace.dart';
import 'package:get/get.dart';

import '../utils/common_function.dart';

class AttendanceController extends GetxController {
  final GetAttendace getAttendance;

  AttendanceController({required this.getAttendance});
  var rotation1 = 1.obs;
  var rotation2 = 1.obs;
  var attendance = Rxn<AttendanceResponseEntity>();
  var attendanceCopy = Rxn<AttendanceResponseEntity>();
  var isLoading = true.obs;
  // var selectedGroups = <String>{}.obs; // Set to store selected buttons
  var selectedGroups = <String, Set<String>>{}.obs;

  var selectedPOS = "".obs;

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  void onInit() async {
    await fetchAttendance();
    initializeSelectedGroups("daily", attendance.value?.groupData ?? []);
    initializeSelectedGroups("weekly", attendance.value?.groupData ?? []);
    super.onInit();
  }

  void setDateRange(DateTime start, DateTime end) {
    startDate.value = start;
    endDate.value = end;
    // fetchAttendanceWithFilter();
  }

  changePos(selecteValue) {
    selectedPOS.value = selecteValue;
    print('changed pos ${selectedPOS.value}');
  }

  void clearDateRange() {
    startDate.value = null;
    endDate.value = null;
    fetchAttendance();
  }

  void toggleSelection(String chartKey, String title) {
    selectedGroups.update(chartKey, (existingSet) {
      if (existingSet.contains(title)) {
        if (existingSet.length > 1) {
          existingSet.remove(title); // Remove only if more than one remains
        }
      } else {
        existingSet.add(title); // Select
      }
      return existingSet;
    }); // Create a new set if it doesn't exist
  }

  bool isSelected(String chartKey, String title) {
    return selectedGroups[chartKey]?.contains(title) ?? false;
  }

  void initializeSelectedGroups(String chartKey, List<GroupEntity> groupData) {
    selectedGroups[chartKey] = groupData.map((e) => e.title).toSet();
  }

  void toggleRotation1() {
    rotation1.value = (rotation1.value == 0) ? 1 : 0;
  }

  void toggleRotation2() {
    rotation2.value = (rotation2.value == 0) ? 1 : 0;
  }

  Future<void> fetchAttendance() async {
    try {
      selectedPOS.value = "";
      isLoading(true);

      Map<String, dynamic> jsonData = {};
      final AttendanceResponseEntity result =
          await getAttendance.execute(jsonData);

      AttendanceResponseEntity updatedResult = updateAttendanceData(result);

      attendanceCopy.value = updatedResult;
      attendance.value = updatedResult;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAttendanceWithFilter() async {
    try {
      selectedPOS.value = "";
      isLoading(true);

      Map<String, dynamic> jsonData = {
        "start_date": startDate.value,
        "end_date": endDate.value
      };
      final AttendanceResponseEntity result =
          await getAttendance.execute(jsonData);
      print('response data ${result}');

      AttendanceResponseEntity updatedResult = updateAttendanceData(result);

      attendanceCopy.value = updatedResult;
      attendance.value = updatedResult;
    } finally {
      isLoading(false);
    }
  }

  AttendanceResponseEntity updateAttendanceData(AttendanceResponseEntity data) {
    List<AttendanceEntity> updateList(List<AttendanceEntity> list) {
      return list.map((entry) {
        String updatedAverage = CommonFunction.calculateAverage(entry.values);
        return AttendanceEntity(
          date: entry.date,
          values: entry.values,
          colors: entry.colors,
          average: updatedAverage, // Updated average value
        );
      }).toList();
    }

    return AttendanceResponseEntity(
      groupData: data.groupData,
      daily: updateList(data.daily),
      weekly: updateList(data.weekly),
      tabFilter: data.tabFilter,
    );
  }

  void filterData(String chartKey, Set<String> selectedGroups) {
    if (attendance.value == null) return;

    List<int> selectedIndices = attendance.value!.groupData
        .asMap()
        .entries
        .where((entry) => selectedGroups.contains(entry.value.title))
        .map((entry) => entry.key)
        .toList();

    List<AttendanceEntity> filterAttendanceData(List<AttendanceEntity> data) {
      return data.map((entry) {
        List<int> selectedValues =
            selectedIndices.map((index) => entry.values[index]).toList();
        String updatedAverage = CommonFunction.calculateAverage(selectedValues);

        return AttendanceEntity(
          date: entry.date,
          values: selectedValues,
          colors: selectedIndices.map((index) => entry.colors[index]).toList(),
          average: updatedAverage,
        );
      }).toList();
    }

    List<AttendanceEntity> filteredDaily = chartKey == "daily"
        ? filterAttendanceData(attendanceCopy.value!.daily)
        : attendance.value!.daily;
    List<AttendanceEntity> filteredWeekly = chartKey == "weekly"
        ? filterAttendanceData(attendanceCopy.value!.weekly)
        : attendance.value!.weekly;

    attendance.value = AttendanceResponseEntity(
      groupData: attendance.value!.groupData,
      daily: filteredDaily,
      weekly: filteredWeekly,
      tabFilter: attendance.value!.tabFilter,
    );
  }
}

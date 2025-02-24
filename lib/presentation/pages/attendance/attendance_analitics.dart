import 'package:attendence_app/presentation/controllers/attendance_controller.dart';
import 'package:attendence_app/presentation/utils/color_const.dart';
import 'package:attendence_app/presentation/widget/custom_bar_chart.dart';
import 'package:attendence_app/presentation/widget/custom_chip.dart';
import 'package:attendence_app/presentation/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceAnalitics extends StatefulWidget {
  @override
  State<AttendanceAnalitics> createState() => _AttendanceAnaliticsState();
}

class _AttendanceAnaliticsState extends State<AttendanceAnalitics> {
  final AttendanceController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.appColor,
      appBar: AppBar(
        title: const Text("Attendance Analitics"),
        backgroundColor: ColorConst.appColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header chips
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: controller.attendance.value?.tabFilter
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: customChip("${e.title}", e.type, context,
                                    controller, e),
                              ))
                          .toList() ??
                      [],
                );
              }),
              const SizedBox(height: 20),
              Center(
                  child: CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bar chart
                    Obx(() {
                      return Column(
                        children: [
                          headerRow(
                              onRotate: controller.toggleRotation1,
                              headerText: "Daily attendance",
                              rotation: controller.rotation1),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomBarChart(
                                title: "Daily attendance",
                                chartKey: "daily",
                                rotation: controller.rotation1.value,
                                attendanceResponse: controller.attendance.value,
                                attendacneData:
                                    controller.attendance.value?.daily,
                                onGroupButtonClick: (value) {
                                  controller.filterData(
                                      'daily', value['daily']);
                                },
                                onRotationClick: controller.toggleRotation1,
                              ),
                              if (controller.isLoading.value)
                                Positioned.fill(
                                  top: 70,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Column(
                        children: [
                          headerRow(
                            onRotate: controller.toggleRotation2,
                            headerText: "Weekly attendance",
                            rotation: controller.rotation2,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomBarChart(
                                title: "Weekly attendance",
                                chartKey: "weekly",
                                rotation: controller.rotation2.value,
                                attendanceResponse: controller.attendance.value,
                                attendacneData:
                                    controller.attendance.value?.weekly,
                                onGroupButtonClick: (value) {
                                  controller.filterData(
                                      'weekly', value['weekly']);
                                },
                                onRotationClick: controller.toggleRotation2,
                              ),
                              if (controller.isLoading.value)
                                Positioned.fill(
                                  top: 70,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

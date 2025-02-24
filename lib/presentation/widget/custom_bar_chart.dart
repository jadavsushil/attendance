import 'package:attendence_app/domain/entities/attendance.dart';
import 'package:attendence_app/presentation/utils/color_const.dart';
import 'package:attendence_app/presentation/utils/text_style.dart';
import 'package:attendence_app/presentation/widget/custom_chip.dart';
import 'package:attendence_app/presentation/widget/rotate_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/attendance_controller.dart';
import '../utils/common_function.dart';

class CustomBarChart extends StatelessWidget {
  final int rotation;
  final String chartKey;
  final String title;
  AttendanceResponseEntity? attendanceResponse;
  List<AttendanceEntity>? attendacneData;
  final Function(dynamic)? onGroupButtonClick;
  VoidCallback? onRotationClick;
  final AttendanceController controller = Get.find();
  CustomBarChart(
      {super.key,
      required this.chartKey,
      required this.rotation,
      required this.title,
      this.attendanceResponse,
      this.attendacneData,
      this.onRotationClick,
      this.onGroupButtonClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: attendanceResponse?.groupData
                          .asMap()
                          .entries
                          .map((entry) {
                        var e = entry.value;
                        Color color = ColorConst().hexToColor(e.color);
                        return Obx(() {
                          bool isSelected =
                              controller.isSelected(chartKey, e.title);
                          return Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: buildGroupButton(
                              "${e.title}",
                              color,
                              isSelected,
                              () {
                                controller.toggleSelection(chartKey, e.title);
                                onGroupButtonClick
                                    ?.call(controller.selectedGroups);
                              },
                            ),
                          );
                        });
                      }).toList() ??
                      [],
                ))),
        Container(
          height: 300,
          width: 400,
          child: (controller.isLoading == false && attendacneData == null) ||
                  controller.isLoading == false && attendacneData!.isEmpty
              ? Center(
                  child: Text(
                    "No attendance data available",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection:
                      rotation == 0 ? Axis.horizontal : Axis.vertical,
                  child: Container(
                    width: rotation == 0
                        ? (attendacneData?.length ?? 10) *
                            ((attendacneData?.length ?? 1) < 5 ? 110 : 60)
                        : 300,
                    height: rotation == 0
                        ? 300
                        : (attendacneData?.length ?? 10) *
                            ((attendacneData?.length ?? 1) < 5 ? 110 : 60),
                    child: BarChart(
                      BarChartData(
                        rotationQuarterTurns: rotation,
                        maxY: 10,
                        barGroups: List.generate(
                          attendacneData?.length ?? 0,
                          (i) => CommonFunction.makeGroupData(
                              i,
                              attendacneData![i]
                                  .values
                                  .map((e) => e.toDouble())
                                  .toList(),
                              attendacneData![i]
                                  .colors
                                  .map((e) => ColorConst().hexToColor(e))
                                  .toList()),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: rotation == 0
                                  ? 50
                                  : 70, // Adjust based on rotation
                              interval:
                                  1, // Show labels at intervals if too many
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index < 0 ||
                                    index >= (attendacneData?.length ?? 0)) {
                                  return const SizedBox.shrink();
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                      width: 40,
                                      child: RotatedText(
                                        rotationQuarterTurns: rotation,
                                        text: attendacneData?[index].date ?? "",
                                        style: TextStyleUtil.titleStyle,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) => RotatedText(
                                rotationQuarterTurns: rotation,
                                text: "${(value * 10).toInt()}%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorConst.appHighLightColor,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  int index = value.toInt();
                                  if (index < 0 ||
                                      index >= (attendacneData?.length ?? 0)) {
                                    return const SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 05),
                                    child: RotatedText(
                                      rotationQuarterTurns: rotation,
                                      text:
                                          attendacneData?[index].average ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  );
                                },
                                reservedSize: 30),
                          ),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            bottom:
                                BorderSide(color: ColorConst.appHighLightColor),
                          ),
                        ),
                        barTouchData: BarTouchData(enabled: false),
                        gridData: FlGridData(
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: ColorConst.appHighLightColor,
                            dashArray: [4, 4],
                            strokeWidth: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

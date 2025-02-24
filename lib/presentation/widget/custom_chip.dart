import 'package:attendence_app/presentation/controllers/attendance_controller.dart';
import 'package:attendence_app/presentation/utils/color_const.dart';
import 'package:attendence_app/presentation/widget/custom_bottom_sheet.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customChip(String text, String type, BuildContext context,
    AttendanceController controller, e) {
  print('e print ${e}');
  return GestureDetector(
    onTap: () {
      handleChipTap(type, text, context, controller, e);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 22),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConst.appHighLightColor, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(color: ColorConst.appHighLightColor, fontSize: 14)),
    ),
  );
}

Widget buildGroupButton(
    String text, Color color, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorConst.appHighLightColor.withOpacity(0.3)
            : Colors.transparent, // Change background when selected
        border: Border.all(
            color: isSelected
                ? ColorConst.blueColor
                : ColorConst.appHighLightColor,
            width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 5),
          Text(text,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    ),
  );
}

void handleChipTap(String type, String text, BuildContext context,
    AttendanceController controller, e) {
  switch (type) {
    case "date":
      showCustomDateRangePicker(
        context,
        dismissible: true,
        minimumDate: DateTime.now().subtract(const Duration(days: 30)),
        maximumDate: DateTime.now().add(const Duration(days: 30)),
        endDate: controller.endDate.value,
        startDate: controller.startDate.value,
        backgroundColor: Colors.white,
        primaryColor: ColorConst.blueColor,
        onApplyClick: (start, end) {
          controller.setDateRange(start, end);
        },
        onCancelClick: () {
          controller.clearDateRange();
        },
      );
      break;

    case "pos":
      customBottomSheet(
          Center(
              child: ListView.builder(
                  itemCount: e.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.changePos(e.data[index].id);
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: controller.selectedPOS.value ==
                                      e.data[index].id
                                  ? ColorConst.appHighLightColor
                                      .withOpacity(0.3)
                                  : ColorConst.appColor,
                              border: Border.all(
                                  color: ColorConst.appHighLightColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('${e.data[index].title}'),
                          )),
                    );
                  })),
          context);
      break;

    case "group":
      controller.onInit();
      break;

    default:
      customBottomSheet(
          Center(
              child:
                  Text("Other: $text", style: const TextStyle(fontSize: 18))),
          context);
      break;
  }
}

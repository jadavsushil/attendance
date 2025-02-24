import 'package:attendence_app/presentation/utils/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;

  const CustomContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child);
  }
}

Widget headerRow({
  required VoidCallback onRotate,
  required String headerText,
  required RxInt rotation, // Independent rotation for each chart
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Icon(Icons.list, color: ColorConst.appHighLightColor),
          const SizedBox(width: 8),
          Text(
            headerText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      IconButton(
        onPressed: onRotate,
        icon: Icon(rotation == 1 ? Icons.rotate_right : Icons.rotate_left,
            color: ColorConst.greyColor),
      ),
    ],
  );
}

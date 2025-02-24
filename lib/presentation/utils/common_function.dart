import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//bar chart group data
class CommonFunction {
  static BarChartGroupData makeGroupData(
      int x, List<double> values, List<Color> colors) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: values.reduce((a, b) => a + b),
          rodStackItems: List.generate(
            values.length,
            (i) => BarChartRodStackItem(
              i == 0 ? 0 : values.sublist(0, i).reduce((a, b) => a + b),
              values.sublist(0, i + 1).reduce((a, b) => a + b),
              colors[i],
            ),
          ),
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  static String calculateAverage(List<int> values) {
    if (values.isEmpty) return "0%";

    int sum = values.reduce((a, b) => a + b);
    int maxPossibleSum = values.length * 10; // Adjust max value if needed
    double average = (sum / maxPossibleSum) * 100;

    return "${average.toStringAsFixed(0)}%"; // Convert to percentage string
  }
}

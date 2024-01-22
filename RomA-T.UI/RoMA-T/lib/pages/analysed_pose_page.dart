import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:rom/extensions/layout_extension.dart';
import 'package:rom/models/estimated_pose.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final double? y;
}

class AnalysedPosePage extends GetResponsiveView {
  AnalysedPosePage({super.key});

  @override
  Widget? phone() {
    final estimatedPose = Get.arguments as EstimatedPose;

    final Map<String, List<ChartData>> chartData = estimatedPose.angles.map(
      (joint, angles) => MapEntry(
        joint,
        angles.asMap().entries.map((e) => ChartData(e.key, e.value)).toList(),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Column(
        children: chartData.entries
            .map(
              (e) => e.value.isNotEmpty
              ? SfCartesianChart(
            title: ChartTitle(text: e.key),
            primaryXAxis:
            NumericAxis(title: AxisTitle(text: 'frame')),
            primaryYAxis:
            NumericAxis(title: AxisTitle(text: 'angle')),
            series: <ChartSeries>[
              // Renders spline chart
              SplineSeries<ChartData, int>(
                dataSource: e.value,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              )
            ],
          )
              : Container(),
        )
            .toList(),
      ).scrollable().marginAll(20),
    );
  }
}

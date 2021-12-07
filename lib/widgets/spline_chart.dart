import 'package:flutter/material.dart';
import 'package:savenote/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChart extends StatelessWidget {
  const SplineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: "Last 7 day",
          textStyle: TextStyle(fontSize: 12),
          alignment: ChartAlignment.near),

      primaryXAxis: CategoryAxis(
          labelPlacement: LabelPlacement.onTicks,
          interval: 1,
          labelRotation: 0,
          axisLine: const AxisLine(width: 0, color: Colors.transparent),
          minorGridLines: const MinorGridLines(width: 0),
          majorGridLines: const MajorGridLines(width: 0)),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelsExtent: 0,
          interval: 2,
          minimum: 14,
          maximum: 20,
          placeLabelsNearAxisLine: false,
          labelFormat: '{value}\$',
          axisLine: const AxisLine(width: 0, color: Colors.transparent),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getGradientAreaSeries(),
      onMarkerRender: (MarkerRenderArgs args) {
        if (args.pointIndex == 0) {
          args.color = Colors.purple;
        } else if (args.pointIndex == 1) {
          args.color = Colors.purple;
        } else if (args.pointIndex == 2) {
          args.color = Colors.purple;
        } else if (args.pointIndex == 3) {
          args.color = Colors.purple;
        } else if (args.pointIndex == 4) {
          args.color = Colors.purple;
        } else if (args.pointIndex == 5) {
          args.color = Colors.purple;
        } else if (args.pointIndex == 6) {
          args.color = Colors.purple;
        }
      },
    );
  }

  List<ChartSeries<_ChartData, String>> _getGradientAreaSeries() {
    final List<_ChartData> chartData = <_ChartData>[
      _ChartData(x: 'Mon', y: 17.70),
      _ChartData(x: 'Tue', y: 18.20),
      _ChartData(x: 'Wed', y: 18),
      _ChartData(x: 'Thu', y: 19),
      _ChartData(x: 'Fri', y: 18.5),
      _ChartData(x: 'Sat', y: 18),
      _ChartData(x: 'Sun', y: 18.80),
    ];
    final List<Color> color = <Color>[];
    color.add(Colors.blue[200]!);
    color.add(Colors.orange[200]!);

    final List<double> stops = <double>[];
    stops.add(0.2);
    stops.add(0.7);

    return <ChartSeries<_ChartData, String>>[
      SplineAreaSeries<_ChartData, String>(
        /// To set the gradient colors for border here.
        borderColor:AppColors.PRIMARY_COLOR
        ,
        /// To set the gradient colors for series.
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color.fromRGBO(15, 200, 0, 0.5), Colors.white],
            stops: <double>[0.1, 1]),
        borderWidth: 2,
        markerSettings: const MarkerSettings(
            isVisible: true,
            height: 8,
            width: 8,
            borderColor: Colors.white,
            borderWidth: 2),
        borderDrawMode: BorderDrawMode.top,
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        name: 'Investment',
      )
    ];
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String? x;
  final double? y;
}

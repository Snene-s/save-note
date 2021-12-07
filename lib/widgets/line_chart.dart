import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class LineChartCustom extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  LineChartCustom( {required this.seriesList,required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory LineChartCustom.withSampleData() {
    return new LineChartCustom(
      seriesList:_createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        defaultRenderer:
        new charts.LineRendererConfig(includeArea: true, stacked: true,areaOpacity: 0.1,roundEndCaps: true),
        animate: animate);

  }

static List<charts.Series<LinearSales, int>> _createSampleData() {

var myFakeMobileData = [
//new LinearSales(0, 15),
new LinearSales(1, 75),
new LinearSales(2, 300),
new LinearSales(3, 225),
  new LinearSales(4, 305), new LinearSales(5, 100), new LinearSales(6, 205),
];

return [

new charts.Series<LinearSales, int>(
id: 'Mobile',
colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
domainFn: (LinearSales sales, _) => sales.year,
measureFn: (LinearSales sales, _) => sales.sales,
data: myFakeMobileData,
),
];
}
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

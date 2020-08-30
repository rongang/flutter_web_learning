/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

class PointsLineChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  Function(int,int) nowSate;

  PointsLineChart(this.seriesList, {this.animate, this.nowSate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  _PointsLineChartState createState() => _PointsLineChartState();

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];
    final data2 = [
      new LinearSales(0, 5),
      new LinearSales(1, 2),
      new LinearSales(2, 10),
      new LinearSales(3, 7),
      new LinearSales(4, 5),
      new LinearSales(5, 2),
      new LinearSales(6, 10),
      new LinearSales(7, 7),
      new LinearSales(8, 50),
      new LinearSales(9, 2),
      new LinearSales(10, 00),
      new LinearSales(11, 5),
    ];
    final data3 = [
      new LinearSales(0, 5),
      new LinearSales(6, 10),
      new LinearSales(7, 7),
      new LinearSales(8, 50),
      new LinearSales(9, 2),
      new LinearSales(10, 00),
      new LinearSales(11, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data3,
      ),
      // new charts.Series<LinearSales, int>(
      //   id: 'Sales',
      //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //   domainFn: (LinearSales sales, _) => sales.year,
      //   measureFn: (LinearSales sales, _) => sales.sales,
      //   data: data2,
      // ),
      // new charts.Series<LinearSales, int>(
      //   id: 'Sales',
      //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      //   domainFn: (LinearSales sales, _) => sales.year,
      //   measureFn: (LinearSales sales, _) => sales.sales,
      //   data: data,
      // ),
    ];
  }
}

class _PointsLineChartState extends State<PointsLineChart> {
  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      widget.seriesList,
      animate: widget.animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      behaviors: [charts.PanBehavior(panningCompletedCallback: (){
        print('press');
        })],
      selectionModels: [SelectionModelConfig(changedListener: (SelectionModel value){
        // print('${(value.selectedDatum[0].datum as LinearSales).sales}');
        LinearSales datum = value.selectedDatum[0].datum;
        widget.nowSate(datum.year,datum.sales);
        // print('${value.selectedSeries[0].displayName}');
        })],
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesAndMetricsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales and Metrics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLineChart(),
              const SizedBox(height: 16),
              _buildPieChart(),
              const SizedBox(height: 16),
              _buildDoughnutChart(),
              const SizedBox(height: 16),
              _buildSplineChart(),
              const SizedBox(height: 16),
              // _buildHorizontalBarChart(),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Line Chart
  Widget _buildLineChart() {
    final List<ChartData> lineData = [
      ChartData('Jan', 200),
      ChartData('Feb', 250),
      ChartData('Mar', 180),
      ChartData('Apr', 300),
      ChartData('May', 220),
    ];

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          title: ChartTitle(text: 'Monthly Sales (Line Chart)'),
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(),
          tooltipBehavior: TooltipBehavior(enable: true),
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
          ),
          series: <LineSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              dataSource: lineData,
              xValueMapper: (data, _) => data.label,
              yValueMapper: (data, _) => data.value,
              markerSettings: const MarkerSettings(isVisible: true),
              animationDuration: 2000,
              color: Colors.blue,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Pie Chart
  Widget _buildPieChart() {
    final List<ChartData> pieData = [
      ChartData('Product A', 40),
      ChartData('Product B', 30),
      ChartData('Product C', 20),
      ChartData('Product D', 10),
    ];

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCircularChart(
          title: ChartTitle(text: 'Product Sales Distribution (Pie Chart)'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <PieSeries<ChartData, String>>[
            PieSeries<ChartData, String>(
              dataSource: pieData,
              xValueMapper: (data, _) => data.label,
              yValueMapper: (data, _) => data.value,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              explode: true,
              explodeIndex: 1,
              animationDuration: 2000,
            ),
          ],
        ),
      ),
    );
  }

  // 3. Doughnut Chart
  Widget _buildDoughnutChart() {
    final List<ChartData> doughnutData = [
      ChartData('Delivery Services', 50, Colors.purple),
      ChartData('Collection', 28, Colors.blue),
      ChartData('Dine-in', 22, Colors.orange),
    ];

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCircularChart(
          title: ChartTitle(text: 'Order Distribution (Doughnut Chart)'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: <DoughnutSeries<ChartData, String>>[
            DoughnutSeries<ChartData, String>(
              dataSource: doughnutData,
              xValueMapper: (data, _) => data.label,
              yValueMapper: (data, _) => data.value,
              pointColorMapper: (data, _) => data.color,
              innerRadius: '60%',
              radius: '85%',
              explode: true,
              explodeIndex: 0,
              animationDuration: 1500,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }

// 4. Enhanced Spline Chart
  Widget _buildSplineChart() {
    final List<ChartData> splineData = [
      ChartData('15', 100),
      ChartData('30', 200),
      ChartData('45', 400),
      ChartData('60', 350),
      ChartData('75', 550),
      ChartData('90', 650),
    ];

    return SizedBox(
      // Dynamically adjust width for scroll
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCartesianChart(
            title: ChartTitle(text: 'Weekly Sales Comparison (Spline Chart)'),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(labelFormat: '\$ {value}'),
            tooltipBehavior: TooltipBehavior(enable: true),
            zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true,
              enablePanning: true,
            ),
            plotAreaBackgroundColor: Colors.grey.shade200,
            series: <SplineAreaSeries<ChartData, String>>[
              SplineAreaSeries<ChartData, String>(
                dataSource: splineData,
                xValueMapper: (data, _) => data.label,
                yValueMapper: (data, _) => data.value,
                gradient: LinearGradient(
                  colors: [Colors.purple.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ), // Shade below the line
                splineType: SplineType.natural, // Smooth curve
                borderColor: Colors.purple,

                borderWidth: 4,
                animationDuration: 1500, // Animation for rendering
                markerSettings: const MarkerSettings(isVisible: true),
                dataLabelSettings: const DataLabelSettings(isVisible: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5. Horizontal Bar Chart
// Widget _buildHorizontalBarChart() {
//   final List<ChartData> barData = [
//     ChartData('Product A', 50.5, Colors.red),
//     ChartData('Product B', 70.8, Colors.green),
//     ChartData('Product C', 30.3, Colors.blue),
//   ];

//   return Card(
//     elevation: 5,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SfCartesianChart(
//         title: ChartTitle(text: 'Product Popularity'),
//         primaryXAxis: NumericAxis(),
//         primaryYAxis: CategoryAxis(),
//         series: <BarSeries<ChartData, String>>[
//           BarSeries<ChartData, String>(
//             dataSource: barData,
//             xValueMapper: (data, _) => data.value.toString(), // Parse to int
//             yValueMapper: (data, _) => data.label.toDouble(), // Keep as String
//             pointColorMapper: (data, _) => data.color,
//             dataLabelSettings: const DataLabelSettings(isVisible: true),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}

// Data Model
class ChartData {
  final String label;
  final double value;
  final Color? color;

  ChartData(this.label, this.value, [this.color]);
}

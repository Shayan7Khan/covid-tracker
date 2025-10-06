import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/reusable_row.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15.0),
          child: Column(
            children: [
              _pieChar(),
              SizedBox(height: _deviceHeight * 0.01),
              _totalData(),
              SizedBox(height: _deviceHeight * 0.01),
              _trackCountries(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pieChar() {
    return PieChart(
      dataMap: {"Total": 20, "Recovered": 15, "Deaths": 5},
      legendOptions: LegendOptions(legendPosition: LegendPosition.right),
      animationDuration: Duration(milliseconds: 1200),
      chartRadius: _deviceWidth / 3.2,
      chartType: ChartType.disc,
      colorList: colorList,
    );
  }

  Widget _totalData() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.06),
      child: Card(
        child: Column(
          children: [
            ReusableRow(title: 'Total', value: "200"),
            ReusableRow(title: 'Total', value: "200"),
            ReusableRow(title: 'Total', value: "200"),
          ],
        ),
      ),
    );
  }

  Widget _trackCountries() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff1aa260),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text('Track Countries')),
    );
  }
}

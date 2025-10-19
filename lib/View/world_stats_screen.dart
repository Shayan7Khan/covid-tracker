import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Widgets/reusable_row.dart';
import '../Models/world_stats_model.dart';

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

  //now we are about to implement the following functionalities

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
    StatsServices statesServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15.0),
          child: Column(
            children: [
              SizedBox(height: _deviceHeight * 0.01),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        
                        _pieChart(snapshot.data!),
                        SizedBox(height: _deviceHeight * 0.01),
                        _totalDataInTableForm(snapshot.data!),
                        SizedBox(height: _deviceHeight * 0.01),
                        _trackCountriesButton(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pieChart(WorldStatsModel worldstats) {
    return PieChart(
      dataMap: {
        "Total": double.parse(worldstats.cases.toString()),
        "Recovered": double.parse(worldstats.recovered.toString()),
        "Deaths": double.parse(worldstats.deaths.toString()),
      },
      chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
      legendOptions: LegendOptions(legendPosition: LegendPosition.right),
      animationDuration: Duration(milliseconds: 1200),
      chartRadius: _deviceWidth / 3.2,
      chartType: ChartType.disc,
      colorList: colorList,
    );
  }

  Widget _totalDataInTableForm(WorldStatsModel worldstats) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.06),
      child: Card(
        child: Column(
          children: [
            ReusableRow(title: 'Total', value: worldstats.cases.toString()),
            ReusableRow(title: 'Deaths', value: worldstats.deaths.toString()),
            ReusableRow(
              title: 'Recovered',
              value: worldstats.recovered.toString(),
            ),
            ReusableRow(title: 'Active', value: worldstats.active.toString()),
            ReusableRow(
              title: 'Critical',
              value: worldstats.critical.toString(),
            ),
            ReusableRow(
              title: 'Today Deaths',
              value: worldstats.todayDeaths.toString(),
            ),
            ReusableRow(
              title: 'Today recovered',
              value: worldstats.todayRecovered.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trackCountriesButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CountriesList()),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff1aa260),
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        'Track Countries',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

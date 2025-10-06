import 'dart:convert';
import '../Models/world_stats_model.dart';
import 'package:covid_tracker/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  Future<WorldStatsModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrls.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrls.countriesStatesApi));
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());

      return data;
    } else {
      throw Exception("Error");
    }
  }
}

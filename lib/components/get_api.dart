import 'dart:convert';

import 'package:covid_tracker/components/covid_api.dart';
import 'package:covid_tracker/models/covid_all_data.dart';
import 'package:http/http.dart' as http;

class GetAPI {
  Future<covidAllDataModel> getCovidAllData() async {
    final response = await http.get(Uri.parse(ApiUrl.allData));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return covidAllDataModel.fromJson(data);
    } else {
      throw Exception("Error in Fetching the data");
    }
  }

  Future<List<dynamic>> getCountriesData() async {
    var data = [];
    final response = await http.get(Uri.parse(ApiUrl.countriesData));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error in Fetching the data");
    }
  }
}

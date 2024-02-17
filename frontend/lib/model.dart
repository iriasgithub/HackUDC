import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Model extends ChangeNotifier {
  late String actualPrice = "";
  late List hourPrices;
  late String maxHourPrice;
  late String maxHourRange;
  late String minHourPrice;
  late String minHourRange;
  late String avgPrice;
  late String consumptionLastMonth;
  late double carbonFootprint;

  late Future<void> updateData;

  Model() {
    updateData = _updateData();
    _startHourlyTimer();
  }

  void _startHourlyTimer() {
    DateTime now = DateTime.now();
    int nextHour = now.hour == 23 ? 0 : now.hour + 1;
    DateTime nextHourTime = DateTime(now.year, now.month, now.day, nextHour);

    Duration durationUntilNextHour = nextHourTime.difference(now);
    //const Duration( seconds: 10)
    Timer(durationUntilNextHour, () {
      updateData = _updateData();

      _startHourlyTimer();
    });
  }

  Future<void> _updateData() async {
    var uri = Uri(
      scheme: 'http',
      host: '10.20.36.108',
      port: 8080,
      path: "/basicdata",
    );
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var dataAsDartMap = jsonDecode(response.body);
      hourPrices = dataAsDartMap["prices"];
      maxHourPrice = dataAsDartMap["max_price"]["price"];
      maxHourRange = dataAsDartMap["max_price"]["range"];
      minHourPrice = dataAsDartMap["min_price"]["price"];
      minHourRange = dataAsDartMap["min_price"]["range"];
      avgPrice = dataAsDartMap["avg_price"];
      carbonFootprint = dataAsDartMap["monthly_carbon_footprint"];


      DateTime now = DateTime.now();
      int index = now.hour;
      consumptionLastMonth = dataAsDartMap["consumption_list"][index];
      actualPrice = dataAsDartMap["prices"][index];
      //actualPrice = "${actualPrice}5";

      notifyListeners();
    }
  }
}

/*Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License. */

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

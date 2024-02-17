import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Model extends ChangeNotifier {
  late double actualPrice;
  late List hourPrices;
  late String maxHourPrice;
  late String minHourPrice;
  late double avgPrice;
  late List avgWastePerHour;

  Model() {
    _updateData();
  }

  Future<void> _updateData() async {
    var uri = Uri(
      scheme: 'http', // El esquema es HTTP si estás usando el puerto 8080
      host: 'localhost', // El host es 'localhost'
      port: 8080, // El puerto es 8080
      path: "/electricity",
    );
    var response = await http.get(uri);
    if(response.statusCode == 200){
      var dataAsDartMap = jsonDecode(response.body);
      hourPrices = dataAsDartMap["prices"];
      maxHourPrice = '$dataAsDartMap["max_price"]["range"] $dataAsDartMap["max_price"]["price"]';
      minHourPrice = '$dataAsDartMap["min_price"]["range"] $dataAsDartMap["min_price"]["price"]';
      avgPrice = dataAsDartMap["number"];

      DateTime now = DateTime.now();
      int index = now.hour;

      avgWastePerHour = dataAsDartMap["consumption-list"][index];
      actualPrice = dataAsDartMap["prices"][index];

    }
  }
}

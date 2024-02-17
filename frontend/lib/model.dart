import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Model extends ChangeNotifier {
  late String actualPrice;
  late List hourPrices;
  late String maxHourPrice;
  late String maxHourRange;
  late String minHourPrice;
  late String minHourRange;
  late String avgPrice;
  late String consumptionList;
  late Future<void> updateData;


  Model() {
    updateData = _updateData();
    //notifyListeners();
    // Calcular el tiempo restante hasta la próxima medianoche
    /*Duration durationUntilNextMidnight = _calculateDurationUntilNextMidnight();

    // Iniciar un temporizador que se active a medianoche
    Timer(durationUntilNextMidnight, () {
      // Llamar a _updateData() cuando sea medianoche
      _updateData();

      // Iniciar un nuevo temporizador que se active cada 24 horas a partir de medianoche
      Timer.periodic(Duration(days: 1), (timer) {
        _updateData();
        notifyListeners();
      });
    });*/
  }

  Future<void> _updateData() async {
    var uri = Uri(
      scheme: 'http', // El esquema es HTTP si estás usando el puerto 8080
      host: '10.20.36.108', // El host es 'localhost'
      port: 8080, // El puerto es 8080
      path: "/electricidad",
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
      //consumptionList = dataAsDartMap["consumption_list"];

      DateTime now = DateTime.now();
      int index = now.hour;

    }
    /*notifyListeners();*/
  }

  /*Duration _calculateDurationUntilNextMidnight() {
    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    Duration durationUntilNextMidnight = nextMidnight.difference(now);
    return durationUntilNextMidnight;
  }*/
}

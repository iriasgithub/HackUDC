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
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voltcare/model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Model(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VoltCare',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    Model model = context.watch<Model>();

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: FutureBuilder(
        future: model.updateData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            double currPrice = double.parse(model.actualPrice);
            // current temperature
            double maxPrice =
                double.parse(model.maxHourPrice); // today max temperature
            double minPrice =
                double.parse(model.minHourPrice); // today min temperature
            String hoursMinPrice = model.minHourRange;
            String hoursMaxPrice = model.maxHourRange;
            double med = (maxPrice - minPrice) / 3;
            double cotaInf = minPrice + med;
            double cotaSup = cotaInf + med;
            double avgPrice =
                double.parse(model.avgPrice); //precio medio del dia
            String expectedCost =
                (double.parse(model.consumptionLastMonth) * currPrice)
                    .toStringAsFixed(3);
            List hourPrices = model.hourPrices;
            double carbonFootprint = model.carbonFootprint;

            Size size = MediaQuery.of(context).size;
            return Center(
              child: Container(
                height: size.height,
                width: size.height,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white,
                ),
                child: SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        //COLUMNA PRINCIPAL

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //--------------------------
                            //ELEMENTOS BLOQUE GRANDE + DERECHO

                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.000001,
                                bottom: size.height * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //elemento izquierda
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //VOLTCARE
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.01,
                                            left: size.width * 0.05,
                                          ),
                                          child: Align(
                                              child: Image.asset(
                                                  "assets/VoltCare.JPG",
                                                  width: 180,
                                                  height: 90)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'Plot price', //Precio actual
                                              style: GoogleFonts.questrial(
                                                color: isDarkMode
                                                    ? Colors.white54
                                                    : Colors.black54,
                                                fontSize: size.height * 0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              '$currPrice€', //current price
                                              style: GoogleFonts.questrial(
                                                color: currPrice <= cotaInf
                                                    ? Color.fromARGB(
                                                        255, 10, 196, 94)
                                                    : currPrice > cotaInf &&
                                                            currPrice <= cotaSup
                                                        ? Colors.indigo
                                                        : Colors.pink,
                                                fontSize: size.height * 0.05,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'kWh',
                                              style: GoogleFonts.questrial(
                                                color: Colors.grey,
                                                fontSize: size.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'Min: $minPrice€',
                                              style: GoogleFonts.questrial(
                                                color: Colors.indigo,
                                                fontSize: size.height * 0.028,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'at $hoursMinPrice',
                                              style: GoogleFonts.questrial(
                                                color: Colors.indigo,
                                                fontSize: size.height * 0.019,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'Max: $maxPrice€',
                                              style: GoogleFonts.questrial(
                                                color: Colors.indigo,
                                                fontSize: size.height * 0.028,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'at $hoursMaxPrice\n',
                                              style: GoogleFonts.questrial(
                                                color: Colors.indigo,
                                                fontSize: size.height * 0.019,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  //elemento derecha
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //recuadro tip
                                        Padding(
                                          padding: EdgeInsets.only(
                                            right: size.width * 0.03,
                                            top: size.height * 0.15,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: isDarkMode
                                                  ? Colors.white
                                                      .withOpacity(0.05)
                                                  : Colors.black
                                                      .withOpacity(0.05),
                                            ),
                                            child: Column(
                                              children: [
                                                //hijos recuadro tip

                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: size.height * 0.01,
                                                      left: size.width * 0.03,
                                                      right: size.width * 0.03,
                                                    ),
                                                    child: Text(
                                                      'Daily tip:',
                                                      style:
                                                          GoogleFonts.questrial(
                                                        color: isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                            size.height * 0.025,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: size.height * 0.01,
                                                        left: size.width * 0.03,
                                                        right:
                                                            size.width * 0.03,
                                                        bottom:
                                                            size.height * 0.03),
                                                    child: Text(
                                                      currPrice <= avgPrice
                                                          ? "Look! Lower price\nthan daily\naverage: $avgPrice€"
                                                          : "Careful with \nexceed consume.\nToday's average\nis $avgPrice€",
                                                      style:
                                                          GoogleFonts.questrial(
                                                        color: isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize:
                                                            size.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.01,
                                            left: size.width * 0.06,
                                          ),
                                          child: Text(
                                            'Expected\nexpenditure:',
                                            style: GoogleFonts.questrial(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: size.height * 0.023,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: size.width * 0.06,
                                          ),
                                          child: Align(
                                            child: Text(
                                              '$expectedCost€\n',
                                              style: GoogleFonts.questrial(
                                                color: isDarkMode
                                                    ? Colors.white54
                                                    : Colors.black54,
                                                fontSize: size.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                            //--------------------------------

                            // BARRA SCROLL HORIZONTAL PRECIOS X DIA

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.black.withOpacity(0.05),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                          left: size.width * 0.03,
                                        ),
                                        child: Text(
                                          'Prices for today',
                                          style: GoogleFonts.questrial(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: size.height * 0.025,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.width * 0.005),
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children:
                                                List.generate(24, (index) {
                                              double price = double.parse(
                                                  hourPrices[
                                                      index]); // Obtener el precio de la lista
                                              String startTime =
                                                  "${index.toString().padLeft(2, '0')}:00"; // Hora de inicio
                                              String endTime =
                                                  "${(index + 1).toString().padLeft(2, '0')}:00"; // Hora de fin
                                              return buildHourRange(
                                                  price,
                                                  startTime,
                                                  endTime,
                                                  size,
                                                  isDarkMode,
                                                  cotaInf,
                                                  cotaSup);
                                            }),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.height * 0.02,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.white.withOpacity(0.05),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.02,
                                          left: size.width * 0.03,
                                        ),
                                        child: Text(
                                          'Monthly carbon fingerprinting',
                                          style: GoogleFonts.questrial(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: size.height * 0.025,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(size.width * 0.005),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                        height: 120,
                                        width: 100,
                                        child: SfRadialGauge(
                                          enableLoadingAnimation: true,
                                          animationDuration: 6000,
                                          axes: <RadialAxis>[
                                            RadialAxis(
                                              minimum: 0,
                                              maximum: 120,
                                              radiusFactor: 1.5,
                                              maximumLabels: 5,
                                              showLastLabel: true,
                                              axisLineStyle:
                                                  const AxisLineStyle(
                                                      thickness: 15),
                                              pointers: <GaugePointer>[
                                                NeedlePointer(
                                                  value: carbonFootprint,
                                                  needleStartWidth: 0.5,
                                                  needleEndWidth: 5,
                                                )
                                              ],
                                              centerY: 0.55,
                                              centerX: 0.9,
                                              ranges: <GaugeRange>[
                                                GaugeRange(
                                                    startValue: 0,
                                                    endValue: 40,
                                                    color: Color.fromARGB(
                                                        255, 10, 196, 94),
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 40,
                                                    endValue: 80,
                                                    color: Color.fromARGB(
                                                        255, 254, 200, 3),
                                                    startWidth: 10,
                                                    endWidth: 10),
                                                GaugeRange(
                                                    startValue: 80,
                                                    endValue: 120,
                                                    color: Colors.pink,
                                                    startWidth: 10,
                                                    endWidth: 10)
                                              ],
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.01,
                                              right: size.width * 0.08,
                                            ),
                                            child: Text(
                                              textAlign: TextAlign.justify,
                                              carbonFootprint <= 40
                                                  ? "Outstanding! You're\nlighting the path\nto a greener\nfuture. 🌟"
                                                  : carbonFootprint > 40 &&
                                                          carbonFootprint <= 80
                                                      ? "Steady! Keep\nheading towards\nsustainability. 💡"
                                                      : "Time to turn the\ntide! Let's make a\nchange for a\nbetter world. 🌍",
                                              style: GoogleFonts.questrial(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: size.height * 0.023,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.height * 0.02,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.white.withOpacity(0.05),
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: size.height * 0.01,
                                          left: size.width * 0.03,
                                        ),
                                        child: Text(
                                          '',
                                          style: GoogleFonts.questrial(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Color.fromARGB(
                                                    255, 66, 66, 66),
                                            fontSize: size.height * 0.025,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildHourRange(double price, String hini, String hfin, size,
      bool isDarkMode, double cotaInf, double cotaSup) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            '$price€',
            style: GoogleFonts.questrial(
              color: price <= cotaInf
                  ? Color.fromARGB(255, 10, 196, 94)
                  : price > cotaInf && price <= cotaSup
                      ? Colors.indigo
                      : Colors.pink,
              fontSize: size.height * 0.025,
            ),
          ),
          Text(
            'kWh',
            style: GoogleFonts.questrial(
              color: Colors.grey,
              fontSize: size.height * 0.023,
            ),
          ),
          Text(
            hini,
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.018,
            ),
          ),
          Text(
            hfin,
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: size.height * 0.018,
            ),
          ),
        ],
      ),
    );
  }
}

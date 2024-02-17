import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          
            String voltCare = "VoltCare"; //city name
            double currPrice = 0.5; // current temperature
            double maxPrice = 0.86; // today max temperature
            double minPrice = 0.35; // today min temperature
            String avgPrice = "0.67"; //precio medio del dia
            String calcDerecha = "0.56"; 
            
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
                            //BARRA SUPERIOR
      
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.04,
                                horizontal: size.width * 0.06,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.bars,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.plusCircle,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ],
                              ),
                            ),
      
                            //--------------------------
                            //ELEMENTOS BLOQUE GRANDE + DERECHO
      
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.03,
                                bottom: size.height * 0.01,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //elemento izquierda
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              voltCare,
                                              style: GoogleFonts.questrial(
                                                color: isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: size.height * 0.06,
                                                fontWeight: FontWeight.bold,
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
                                              'Now', //day
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
                                            top: size.height * 0.03,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              '$currPrice€', //curent price
                                              style: GoogleFonts.questrial(
                                                color: currPrice <= 0
                                                    ? Colors.blue
                                                    : currPrice > 0 && currPrice <= 15
                                                        ? Colors.indigo
                                                        : currPrice > 15 &&
                                                                currPrice < 30
                                                            ? Colors.deepPurple
                                                            : Colors.pink,
                                                fontSize: size.height * 0.13,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.25),
                                          child: Divider(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.005,
                                            left: size.width * 0.08,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'Average price: $avgPrice€', // precio medio
                                              style: GoogleFonts.questrial(
                                                color: isDarkMode
                                                    ? Colors.white54
                                                    : Colors.black54,
                                                fontSize: size.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: size.height * 0.03,
                                            bottom: size.height * 0.03,
                                            left: size.width * 0.08,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'min $minPrice€', // min temperature
                                                style: GoogleFonts.questrial(
                                                  color: minPrice <= 0
                                                      ? Colors.blue
                                                      : minPrice > 0 && minPrice <= 15
                                                          ? Colors.indigo
                                                          : minPrice > 15 &&
                                                                  minPrice < 30
                                                              ? Colors.deepPurple
                                                              : Colors.pink,
                                                  fontSize: size.height * 0.03,
                                                ),
                                              ),
                                              Text(
                                                '/',
                                                style: GoogleFonts.questrial(
                                                  color: isDarkMode
                                                      ? Colors.white54
                                                      : Colors.black54,
                                                  fontSize: size.height * 0.03,
                                                ),
                                              ),
                                              Text(
                                                'max $maxPrice€', //max temperature
                                                style: GoogleFonts.questrial(
                                                  color: maxPrice <= 0
                                                      ? Colors.blue
                                                      : maxPrice > 0 && maxPrice <= 15
                                                          ? Colors.indigo
                                                          : maxPrice > 15 &&
                                                                  maxPrice < 30
                                                              ? Colors.deepPurple
                                                              : Colors.pink,
                                                  fontSize: size.height * 0.03,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                  //elemento derecha
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'Higher than average\nmonthly price', // weather
                                              style: GoogleFonts.questrial(
                                                color: isDarkMode
                                                    ? Colors.white54
                                                    : Colors.black54,
                                                fontSize: size.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'min $calcDerecha€\n', // min temperature
                                              style: GoogleFonts.questrial(
                                                color: minPrice <= 0
                                                    ? Colors.blue
                                                    : minPrice > 0 && minPrice <= 15
                                                        ? Colors.indigo
                                                        : minPrice > 15 && minPrice < 30
                                                            ? Colors.deepPurple
                                                            : Colors.pink,
                                                fontSize: size.height * 0.03,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                          ),
                                          child: Align(
                                            child: Text(
                                              'Data type\n\n\n\n\n', // weather
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
                                      padding: EdgeInsets.all(size.width * 0.005),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            //TODO: change weather forecast from local to api get
                                            buildForecastToday(
                                              "0,52", //precio
                                              "00:00", //hora inicio periodo
                                              "01:00", //hora fin periodo
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,36",
                                              "01:00",
                                              "02:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,45",
                                              "02:00",
                                              "03:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,48",
                                              "03:00",
                                              "04:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,56",
                                              "04:00",
                                              "05:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,89",
                                              "05:00",
                                              "06:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,79",
                                              "06:00",
                                              "07:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,68",
                                              "07:00",
                                              "08:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,56",
                                              "08:00",
                                              "09:00",
                                              size,
                                              isDarkMode,
                                            ),
                                            buildForecastToday(
                                              "0,57",
                                              "09:00",
                                              "10:00",
                                              size,
                                              isDarkMode,
                                            ),
                                          ],
                                        ),
                                      ),
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
                                          'Data Information',
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
                                      color: isDarkMode ? Colors.white : Colors.black,
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

  Widget buildForecastToday(
      String price, String hini, String hfin, size, bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.025),
      child: Column(
        children: [
          Text(
            '$price€',
            style: GoogleFonts.questrial(
              color: isDarkMode ? Colors.white : Colors.black,
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

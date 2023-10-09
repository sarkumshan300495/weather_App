import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherapp/screens/bottom_screen.dart';
import 'package:weatherapp/screens/list_screen.dart';
import 'package:http/http.dart' as http;

import 'secrets.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

    late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openweatherAPI"));
      print(res.body);
      final data = jsonDecode(res.body); // convet json format to normal format

      if (data['cod'] != 200) {
        throw Exception('Failed to load data from API');
      }
      return data;
      // data['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

    @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
                setState(() {
                weather = getCurrentWeather();
              });
            },
          )
        ],
        title: const Text("Weather App"),
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
            ));
          }
          final data = snapshot.data!;

          final temperature = data['main']['temp'];
          final currentSky = data['weather'][0]['main'];
          final humanity = data['main']['humidity'];
          final presurre = data['main']['pressure'];
          final windSpeed = data['wind']['speed'];
         
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 20,
                  child: Container(
                    width: sizeWidth,
                    height: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.black12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textshortcut(
                          fontsize: 28,
                          textname: '$temperature K',
                          fontweight: FontWeight.bold,
                        ),
                        Image.network(
                          "https://static.vecteezy.com/system/resources/previews/012/066/499/original/sunny-and-rainy-day-weather-forecast-icon-meteorological-sign-3d-render-png.png",
                          fit: BoxFit.cover,
                          width: 20,
                        ),
                        Icon(
                          currentSky == 'Clouds' || currentSky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          size: 80,
                        ),
                        textshortcut(
                          fontsize: 20,
                          textname: '$currentSky',
                          fontweight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                textshortcut(
                    textname: "Weather Forcaste",
                    fontsize: 20,
                    fontweight: FontWeight.bold),
                SizedBox(),
                // SizedBox(
                //     height: 150,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       padding: const EdgeInsets.all(8),
                //       children: listScreens,
                //     )),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount:5,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: ( context,  index) {
                          final data1 = data['main'] ;
                          final dt = data['dt'].toString();
                          final temp = data1['temp'].toString();
                          return ListScreen(
                              frenhit:temp,
                              time: dt,
                              icon: Icons.cloud,
                            );
                        },

                    ),
                    ),
                textshortcut(
                    textname: "Additional Information",
                    fontsize: 20,
                    fontweight: FontWeight.bold),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomScreen(
                        icon: Icons.water_drop,
                        text: "Humadity",
                        degree: "$humanity"),
                    BottomScreen(
                        icon: Icons.wind_power,
                        text: "Wind Speec",
                        degree: "$presurre"),
                    BottomScreen(
                        icon: Icons.umbrella_rounded,
                        text: "Pressure",
                        degree: "$windSpeed"),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget textshortcut(
      {required String textname,
      required double fontsize,
      required FontWeight fontweight}) {
    return Text(
      textname,
      style: TextStyle(
          fontSize: fontsize, fontWeight: fontweight, color: Colors.white),
    );
  }
}

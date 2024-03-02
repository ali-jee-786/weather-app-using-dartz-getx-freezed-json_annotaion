import 'package:best_weather_app/data/weather_api.dart';
import 'package:best_weather_app/views/widgets/error_refresh.dart';
import 'package:best_weather_app/views/widgets/reuseable_row.dart';
import 'package:best_weather_app/views/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = WeatherApi();
  TextEditingController searchController = TextEditingController();
  var location = 'Islamabad';
  var bgImgUrl = 'https://w0.peakpx.com/wallpaper/1001/142/HD-wallpaper-space-black-stars-night-dark.jpg';
  String formatDate = DateFormat('EEEE, d MMMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: FutureBuilder(
                future: api.getWeatherData(location),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var result = snapshot.data;
                    return result!.fold((l) {
                      String iconCode = l.icon.toString();
                      return Stack(
                        children: [
                          const SizedBox(height: 20,),
                          Image.network(
                            bgImgUrl,
                            height: 900,
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${l.name}, ${l.country}', style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                    SearchField(
                                      Controller: searchController,
                                      onSubmit: (String val) {
                                        setState(() {
                                          location = val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              Image.network(
                                'https://openweathermap.org/img/w/$iconCode.png',
                                height: MediaQuery.sizeOf(context).height * 0.25,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.black,
                                child: Column(
                                  children: [
                                    Text(
                                      '${l.temp} °C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 45,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      l.weather,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      formatDate,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              ReuseableRow(
                                  title1: 'Feels like',
                                  value1:
                                  '${l.feels_like} °C'.toString(),
                                  icon1: Icons.cloud,
                                  title2: 'Wind',
                                  value2: '${l.wind} km/h'.toString(),
                                  icon2: Icons.wind_power),
                              const SizedBox(
                                height: 25,
                              ),
                              ReuseableRow(
                                  title1: 'Humidity',
                                  value1: '${l.humidity} %'.toString(),
                                  icon1: Icons.water_drop,
                                  title2: 'Pressure',
                                  value2: l.pressure.toString(),
                                  icon2: Icons.cloudy_snowing),
                            ],
                          ),
                        ],
                      );
                    }, (r) {
                      return ErrorRefresh(
                        ontap: () {
                          setState(() {
                            location = 'Islamabad';
                          });
                        },
                      );
                    });
                  }
                  else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }
                },
              ),
            ),
          ),
        ));
  }
}

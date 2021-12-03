import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'city_list.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  dynamic temp;
  String weatherIcon;
  String weatherMessage;
  String cityName;
  String weatherCondition;
  dynamic humidity;
  String home;
  dynamic wind;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      dynamic localtemp = weatherData['main']['temp'];
      temp = localtemp.toInt();
      var condition = weatherData['weather'][0]['id'];
      dynamic dt = weatherData['dt'];
      dynamic sunset = weatherData['sys']['sunset'];
      dynamic sunrise = weatherData['sys']['sunrise'];
      home = backgroundImage(dt, sunset, sunrise);
      weatherIcon = weather.getWeatherImg(condition, dt, sunset, sunrise);
      weatherCondition = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];
      wind = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(home),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var cityName =
                            await Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CityScreen(
                              home: home,
                            );
                          },
                        ));
                        if (cityName != null) {
                          CityWeather cityWeather = CityWeather(cityName);
                          var locationWeather =
                              await cityWeather.getCityWeather();
                          updateUI(locationWeather);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            cityName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CityListPage(
                              home: home,
                            );
                          },
                        ));
                      },
                      child: Icon(
                        Icons.subject,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Image(
                    image: AssetImage(weatherIcon),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 2,
                  child: Card(
                    color: Colors.white12,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 10,
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 30),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            '${temp.toString()}°c',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cabin',
                            ),
                          ),
                          Text(
                            weatherCondition,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.wind,
                                color: Colors.white70,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Wind    ||    $wind',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.handHoldingWater,
                                color: Colors.white70,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Wind    ||    $humidity',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

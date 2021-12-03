import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '7eae942b1f638c257f0e652489e18534';
const link = "http://api.openweathermap.org/data/2.5/weather";

class LocationWeather {
  final Location location;
  LocationWeather(this.location);
  Future<dynamic> locationWeatherData() async {
    String url =
        '$link?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
  }
}

class CityWeather {
  final String cityName;
  CityWeather(this.cityName);
  Future<dynamic> getCityWeather() async {
    String url = '$link?q=$cityName&appid=$apiKey&units=metric';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
  }
}

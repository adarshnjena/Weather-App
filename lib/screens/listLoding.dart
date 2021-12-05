import 'package:clima/screens/city_list.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/List.dart';

class ListLoadingScreen extends StatefulWidget {
  ListLoadingScreen({this.home, this.listMemory});
  final home;
  final List listMemory;
  @override
  _ListLoadingScreenState createState() => _ListLoadingScreenState();
}

class _ListLoadingScreenState extends State<ListLoadingScreen> {
  @override
  void initState() {
    super.initState();
    loding();
  }

  void loding() async {
    List<ValueData> valueData = [];

    for (var i = 0; i < widget.listMemory.length; i++) {
      GetListData getListData = GetListData(cityName: widget.listMemory[i]);
      await getListData.getdata();
      ValueData temp = ValueData(
          temp: getListData.temp,
          wind: getListData.wind,
          weatherIcon: getListData.weatherIcon);
      valueData.add(temp);
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return CityListPage(
        home: widget.home,
        valueData: valueData,
        listMemory: widget.listMemory,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class GetListData {
  GetListData({@required this.cityName});
  final String cityName;
  dynamic temp;
  dynamic wind;
  String weatherIcon;
  Future<void> getdata() async {
    CityWeather cityData = CityWeather(cityName);
    WeatherModel weather = WeatherModel();
    dynamic weatherData = await cityData.getCityWeather();
    dynamic localtemp = weatherData['main']['temp'];
    temp = localtemp.toInt();
    var condition = weatherData['weather'][0]['id'];
    dynamic dt = weatherData['dt'];
    dynamic sunset = weatherData['sys']['sunset'];
    dynamic sunrise = weatherData['sys']['sunrise'];
    wind = weatherData['wind']['speed'];
    weatherIcon = weather.getWeatherImg(condition, dt, sunset, sunrise);
  }

  dynamic getTemp() {
    return temp;
  }

  dynamic getWind() {
    return wind;
  }

  dynamic getWeatherIcon() {
    return weatherIcon;
  }
}

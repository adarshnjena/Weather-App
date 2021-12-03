import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  Future<List> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      latitude = 22.5726;
      longitude = 88.3639;
    }
    List<dynamic> val = [latitude, longitude];
    return val;
  }
}

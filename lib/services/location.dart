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
      latitude = 21.1458;
      longitude = 79.0882;
    }
    List<dynamic> val = [latitude, longitude];
    return val;
  }
}

import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  Future<void> getCurrentlocation() async {
    try {
      LocationPermission locationPermission = await Geolocator
          .requestPermission();

      if (LocationPermission.whileInUse == locationPermission ||
          LocationPermission.always == locationPermission) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      }
    }
    catch (e) {
      print(e);
    }
  }
}
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

const Apikey= 'e09d1e96f4892e738203671362b20a14';
const weatherDataUrl= 'https://api.openweathermap.org/data/2.5/forecast';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
  NetworkHelper networkHelper = NetworkHelper(
  '$weatherDataUrl?q=$cityName&appid=$Apikey&units=metric');

  var weatherData = await networkHelper.getData();
  return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location= Location();
    await location.getCurrentlocation();
    
    NetworkHelper networkHelper = NetworkHelper('$weatherDataUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$Apikey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
}
}

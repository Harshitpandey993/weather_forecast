import 'package:weather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';
import 'city_screen.dart';
import 'Forecast_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();
  var temperature;
  int humidity;
  double windSpeed;
  var cityname;
  var disCrip;
  var data;
  bool isCelsius = true;


  // String message;
  // String cityName;
  @override
  void initState(){
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        humidity=0;
        windSpeed=0;
        disCrip='Error';
        return;
      }
        temperature= weatherData['list'][0]['main']['temp'];
        humidity= weatherData['list'][0]['main']['humidity'];
        windSpeed= weatherData['list'][0]['wind']['speed'];
        disCrip= weatherData['list'][0]['weather'][0]['description'];
        data=weatherData;
        cityname =weatherData['city']['name'];

      if (!isCelsius)  {
        temperature = (temperature * 1.8) + 32;
      }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/location_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),

      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    var weatherData = await weather.getLocationWeather();
                    updateUI(weatherData);
                  },
                  child: Icon(
                    Icons.near_me,
                    size: 50.0,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    var typedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ),
                    );
                    if (typedName != null) {
                      var weatherData =
                      await weather.getCityWeather(typedName);
                      updateUI(weatherData);
                    }
                  },
                  child: Icon(
                    Icons.location_city,
                    size: 50.0,
                  ),
                ),
              ],
            ),

          Padding(padding: EdgeInsets.only(bottom: 10.0),
            child: Text('Currently in $cityname',
             style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          ),

             Text(
              ' ${temperature.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
              style: kTempTextStyle,
            ),

            Text(
              ' $disCrip',
              style: kTempTextStyle,
            ),

        ],
      ),
          ),
    ),

      Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.00),
                    child: ListView(
                      children: <Widget>[
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.thermometer),
                        title: Text('Temperature:'),
                        trailing: Text('${temperature.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}'),
                      ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.wind),
                          title: Text('Windspeed:'),
                          trailing: Text('$windSpeed'),
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.cloud),
                          title: Text('Humidity:'),
                          trailing: Text('$humidity'),
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.sun),
                          title: Text('Description:'),
                          trailing: Text('$disCrip'),
                        ),


                        Align(
                          alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton( onPressed:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ForecastScreen(
                                locationWeather: data,
                              );
                            }));
                          },
                            child: Text(
                              'Future forecast',
                              style: kTempTextStyle,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue, // background color
                              onPrimary: Colors.white, // text color
                            ),
                          ),
                        ),
                      ),

                        SizedBox(
                          height: 20,
                          width: 400,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton( onPressed:() {
                                      setState((){
                                     isCelsius=!isCelsius;
                                     updateUI(data);
                                     });
                            },
                              child: Text(
                                'Toggle scale',
                                style: kTempTextStyle,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // background color
                                onPrimary: Colors.white, // text color
                              ),
                            ),
                          ),
                        ),

    ],
    ),
    ),
      ),
            ],
          ),
        );
  }
}
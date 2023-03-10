import 'package:weather/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';


class ForecastScreen extends StatefulWidget {
  ForecastScreen({this.locationWeather});

  final locationWeather;

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  WeatherModel weather=WeatherModel();
  var temperaturemax1;
  var temperaturemax2;
  var temperaturemax3;
  var temperaturemax4;
  var temperaturemax5;
  var temperaturemin1;
  var temperaturemin2;
  var temperaturemin3;
  var temperaturemin4;
  var temperaturemin5;
  String disc1;
  String disc2;
  String disc3;
  String disc4;
  String disc5;
  String cityName;
  bool isCelsius = true;
  var data;
  var dateString;
  var date2String;
  var date3String;
  var date4String;
  var date5String;

  @override
  void initState(){
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData == null) {
        temperaturemax1 = 0;
        temperaturemax2 = 0;
        temperaturemax3 = 0;
        temperaturemax4 = 0;
        temperaturemax5 = 0;
        temperaturemin2 = 0;
        temperaturemin3 = 0;
        temperaturemin4 = 0;
        temperaturemin1 = 0;
        temperaturemin5 = 0;

        disc1 = 'Error';
        disc2 = 'Error';
        disc3 = 'Error';
        disc4 = 'Error';
        disc5 = 'Error';

        return;
      }
      temperaturemax1 = weatherData['list'][0]['main']['temp_max'];
      temperaturemax2 = weatherData['list'][8]['main']['temp_max'];
      temperaturemax3 = weatherData['list'][16]['main']['temp_max'];
      temperaturemax4 = weatherData['list'][24]['main']['temp_max'];
      temperaturemax5 = weatherData['list'][32]['main']['temp_max'];

      temperaturemin1 = weatherData['list'][0]['main']['temp_min'];
      temperaturemin2 = weatherData['list'][8]['main']['temp_min'];
      temperaturemin3 = weatherData['list'][16]['main']['temp_min'];
      temperaturemin4 = weatherData['list'][24]['main']['temp_min'];
      temperaturemin5 = weatherData['list'][32]['main']['temp_min'];

      disc1 = weatherData['list'][0]['weather'][0]['description'];
      disc2 = weatherData['list'][8]['weather'][0]['description'];
      disc3 = weatherData['list'][16]['weather'][0]['description'];
      disc4 = weatherData['list'][24]['weather'][0]['description'];
      disc5 = weatherData['list'][32]['weather'][0]['description'];

      cityName =weatherData['city']['name'];

      final now = DateTime.now();
      final dateTimeString = now.toString();
      dateString = dateTimeString.substring(0, 10);
      final dateTime = DateTime.parse(dateString);
      final nextDayDateTime = dateTime.add(Duration(days: 1));
      date2String = nextDayDateTime.toString().substring(0, 10);
      final nextDayDate2Time = dateTime.add(Duration(days: 2));
      date3String = nextDayDate2Time.toString().substring(0, 10);
      final nextDayDate3Time = dateTime.add(Duration(days: 3));
      date4String = nextDayDate3Time.toString().substring(0, 10);
      final nextDayDate4Time = dateTime.add(Duration(days: 4));
      date5String = nextDayDate4Time.toString().substring(0, 10);

      data = weatherData;
      if (!isCelsius)  {
        temperaturemax1 = (temperaturemax1 * 1.8) + 32;
        temperaturemax2 = (temperaturemax2 * 1.8) + 32;
        temperaturemax3 = (temperaturemax3 * 1.8) + 32;
        temperaturemax4 = (temperaturemax4 * 1.8) + 32;
        temperaturemax5 = (temperaturemax5 * 1.8) + 32;
        temperaturemin1 = (temperaturemin1 * 1.8) + 32;
        temperaturemin2 = (temperaturemin2 * 1.8) + 32;
        temperaturemin3 = (temperaturemin3 * 1.8) + 32;
        temperaturemin4 = (temperaturemin4 * 1.8) + 32;
        temperaturemin5 = (temperaturemin5 * 1.8) + 32;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  )
        ],
      ),
              Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.00),
                      child: Text('Forecast in $cityName',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
              ],
                ),
                      color: Theme.of(context).colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
              SizedBox(
                width: 200.0,
                height: 10.0,
              ),


                Padding(
                padding: EdgeInsets.all(20.00),
                child: Column(
                  children: [
                    Card(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.00),
                          child: Text('$dateString',
                              style: kTempTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Min Temp: ${temperaturemin1.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'} ',
                            style: kTempTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Max Temp: ${temperaturemax1.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
                            style: kTempTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Weather: $disc1',
                            style: kTempTextStyle,
                          ),
                        ),
                      ],
                    ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),

                    SizedBox(
                      width: 200.0,
                      height: 20.0,
                    ),

                    Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.00),
                            child: Text('$date2String',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Min Temp: ${temperaturemin2.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'} ',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Max Temp: ${temperaturemax2.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Weather: $disc2',
                              style: kTempTextStyle,
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),

                    SizedBox(
                      width: 200.0,
                      height: 20.0,
                    ),

                    Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.00),
                            child: Text('$date3String',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Min Temp: ${temperaturemin3.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'} ',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Max Temp: ${temperaturemax3.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Weather: $disc3',
                              style: kTempTextStyle,
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),

                    SizedBox(
                      width: 200.0,
                      height: 20.0,
                    ),

                    Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.00),
                            child: Text('$date4String',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Min Temp: ${temperaturemin4.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'} ',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Max Temp: ${temperaturemax4.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Weather: $disc4',
                              style: kTempTextStyle,
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                    ),

                    SizedBox(
                      width: 200.0,
                      height: 20.0,
                    ),

                    Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.00),
                            child: Text('$date5String',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Min Temp: ${temperaturemin5.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'} ',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Max Temp: ${temperaturemax5.toStringAsFixed(1)} ${isCelsius ? '°C' : '°F'}',
                              style: kTempTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Weather: $disc5',
                              style: kTempTextStyle,
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
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
            ],
          ),
        ),
      ),
    ],
      ),
    );
  }
}

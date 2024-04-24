import '/services/weathermodel.dart';
import 'package:flutter/material.dart';
import '/services/weathermodel.dart';
import '/screens/cityscreen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});

  final dynamic locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  @override
  void initState() {
    updateUI(widget.locationWeather);

    super.initState();
    print(widget.locationWeather);
  }

  void updateUI(dynamic location) {
 setState(() {
   if (location == null) {
     temperature = 0;
     cityName = '-';
     weatherIcon = 'error';
     return;
   }

   double temp = location['main']['temp'];
   temperature = temp.toInt();
   var condition = location['weather'][0]['id'];
   cityName = location['name'];
   weatherIcon = weatherModel.getWeatherIcon(condition);
 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    var weather = await weatherModel.getCurrentLocation();
                    updateUI(weather);
                    print(weather);
                  },
                  child: const Icon(
                    Icons.near_me,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    var typedName = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CityScreen();
                    }));
                    if(typedName != null){
                      var weather  = await weatherModel.getCityLocation(typedName);
                      updateUI(weather);

                    }
                    print(typedName);
                  },
                  child: const Icon(
                    Icons.location_city,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$temperature°c',
                  style: const TextStyle(fontSize: 70),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '$weatherIcon',
                  style: const TextStyle(fontSize: 30),
                )
              ],
            ),
            Center(
              child: Text(
                '$cityName',
                style: const TextStyle(fontSize: 35),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

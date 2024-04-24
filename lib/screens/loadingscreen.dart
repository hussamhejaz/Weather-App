import 'package:flutter/material.dart';
import 'package:weather_app/screens/locationscreen.dart';
import '/services/weathermodel.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    getLocationData();

    super.initState();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getCurrentLocation();


    if(!mounted) return;
      Navigator.push( context, MaterialPageRoute(builder:(context){
        return  LocationScreen(locationWeather: weatherData,);
      }));


  }

  @override
  Widget build(BuildContext context) {
    // getLocationData();
    return  const Scaffold(
      body:Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ) ,

    );
  }
}

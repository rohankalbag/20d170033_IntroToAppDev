import 'package:climateapp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climateapp/services/location.dart';
import 'package:flutter/rendering.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  WeatherReport currentWeather = WeatherReport();
  LocationGetter currentLocation = LocationGetter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pic3.jpg'),
            fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Climate App", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () async{
                    Navigator.pushNamed(context, '/');
                    await currentLocation.obtainLocation();
                    currentWeather.setLatLong(currentLocation.newLatitude,currentLocation.newLongitude);
                    await currentWeather.getTempWithLatLong();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/city', arguments: {
                      'cityName': 'Your Place',
                      'temp': currentWeather.temperature,
                      'desc': currentWeather.description
                    });
                  },
                  child: Text("Lets Go!")
              )
            ],
          )
        )
            )
        );
  }
}

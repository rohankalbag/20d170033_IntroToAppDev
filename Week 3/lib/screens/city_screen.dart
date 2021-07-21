import 'package:climateapp/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climateapp/services/location.dart';

class City extends StatefulWidget {
  const City({Key? key}) : super(key: key);
  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  WeatherReport currentWeather = WeatherReport();
  LocationGetter currentLocation = LocationGetter();
  Map data = {};
  Widget suggestionGenerator(String temp){
    double intTemp = double.parse(temp);
    if(intTemp>=35) {
      return Text('\t Its sweltering!\n\n It is 🍦 time at \n\t\t\t\t\t\t ${data['cityName']}', style: TextStyle(fontSize: 40, color: Colors.white),);
    }
    else if(intTemp>=18 && intTemp<=35){
      return Text(' \t\t\t\t Its Perfect!\n\n Time to go out at \n\t\t\t\t\t\t ${data['cityName']}', style: TextStyle(fontSize: 40, color: Colors.white),);
    }
    else{
      return Text('\t\t\t\t\t\t\t Brrrrrr!\n\n It is ☕ time at \n\t\t\t\t\t\t ${data['cityName']}', style: TextStyle(fontSize: 40, color: Colors.white),);
    }
  }
  Widget iconGenerator(String desc){
      if(desc=='Clouds'){
        return Icon(Icons.cloud, color: Colors.white, size: 60,);
      }
      else if(desc=='Clear'){
          return Icon(Icons.wb_sunny, color: Colors.orange, size:60,);
      }
      else if(desc=="Mist"){
        return Icon(Icons.waves, color: Colors.white, size:60,);
      }
      else {
        return Text('');
      }
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    print(data['desc']);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/pic2.jpeg'),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async{
                      Navigator.pushNamed(context, '/');
                      await currentLocation.obtainLocation();
                      currentWeather.setLatLong(currentLocation.newLatitude,currentLocation.newLongitude);
                      await currentWeather.getTempWithLatLong();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/city', arguments: {
                        'cityName': 'your place',
                        'temp': currentWeather.temperature,
                        'desc': currentWeather.description
                      });
                    },
                    child: Icon(Icons.gps_fixed, color: Colors.white, size: 40),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/weather');
                    },
                      child: Icon(Icons.apartment, color: Colors.white,
                          size: 40)
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 200, 5, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['temp']+'°', style: TextStyle(fontSize: 70,color: Colors.white)),
                    iconGenerator(data['desc']),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  suggestionGenerator(data['temp']),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

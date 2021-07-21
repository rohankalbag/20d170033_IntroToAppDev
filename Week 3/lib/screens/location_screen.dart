import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:climateapp/services/weather.dart';

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherReport currentWeather = WeatherReport();
  final myController = TextEditingController();
  String userInputCity = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/pic1.jpg"),
                fit: BoxFit.cover
              )
            ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        children:[
                        SizedBox(height:15.0),
                        Icon(Icons.apartment, color: Colors.white, size: 30)
                        ]
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 300.0,
                      height: 60.0,
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter city',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        userInputCity = myController.text;
                        Navigator.pushNamed(context, '/');
                        currentWeather.setCityName(userInputCity);
                        await currentWeather.getTempWithCityName();
                        Navigator.pop(context);
                        if(currentWeather.isCorrect) {
                            Navigator.pushReplacementNamed(
                                context, '/city', arguments: {
                              'cityName': currentWeather.cityName,
                              'temp': currentWeather.temperature,
                              'desc': currentWeather.description
                            });
                        }
                        else{
                          myController.text = 'Wrong City Entered!';
                        }
                      },
                      child: Text('Get Weather',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart';

class WeatherReport{
  String temperature = '';
  String cityName = '';
  String latitude = '';
  String longitude = '';
  String description = '';
  bool isCorrect = true;

  void setCityName(String city){
    this.cityName = city;
  }

  void setLatLong(String lat, String long){
    this.longitude = long;
    this.latitude = lat;
  }

  Future<void> getTempWithCityName() async {
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${this
            .cityName}&appid=bb3c5578a28ca72e10705b46c1599dd2'));
    Map jsonData = jsonDecode(response.body);
    if (jsonData['cod'] == 200) {
      this.temperature = (jsonData['main']["feels_like"] - 273).toStringAsFixed(1);
      this.description = (jsonData['weather'][0]["main"]).toString();
      this.isCorrect = true;
    }
    else{
      this.isCorrect = false;
    }
  }

  Future<void> getTempWithLatLong() async{
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${this.latitude}&lon=${this.longitude}&appid=bb3c5578a28ca72e10705b46c1599dd2'));
    Map jsonData = jsonDecode(response.body);
    this.temperature = (jsonData['main']["feels_like"] - 273).toStringAsFixed(1);
    this.description = (jsonData['weather'][0]['main']).toString();
    this.isCorrect = true;
  }

}

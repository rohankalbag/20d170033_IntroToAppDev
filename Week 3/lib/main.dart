
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'screens/city_screen.dart';
import 'screens/location_screen.dart';
import 'screens/intro_page.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/intro',
  routes: {
    '/intro': (context) => Intro(),
    '/': (context) => Loading(),
    '/city': (context) => City(),
    '/weather': (context) => Weather()
  },
));
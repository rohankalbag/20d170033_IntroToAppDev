import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/intro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytodo/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        useLoader: true,
        loadingText: Text(""),
        navigateAfterSeconds: result != null ? Home(uid: result.uid) : SignUp(),
        seconds: 5,
        title: new Text(
          'Welcome To Todo App',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.purple);
  }
}

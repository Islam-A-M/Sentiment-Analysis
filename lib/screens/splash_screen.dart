import 'package:flutter/material.dart';
import '../screens/home.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      image: Image.asset('assets/theater.png'),
      gradientBackground: LinearGradient(
          colors: [
            Color(0xFFe100ff),
            Color(0xFF8E2DE2),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.004, 1]),
      title: Text(
        'Sentiment Analysis',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}

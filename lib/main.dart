import 'dart:convert';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Screens/SplashScreen.dart';
import 'Screens/WeatherSearchScreen.dart';
import 'dart:ui';


void main()
{
  runApp( MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.black,          // Primary color
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,          // Defines all shades
      ),),
    title: "Weather",
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}



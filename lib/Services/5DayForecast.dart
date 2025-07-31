import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'Location.dart';

Future<List<Map<String,dynamic>>> getWeather(String? city)async
{
  var data;
  Location location=Location();
  List<Map<String,dynamic>> dailyForecastList=[];
  double lat=0.0 , lon=0.0 ;
  if(city==null)
  {
    Position position = await location.getCurrentPosition();
    lat = position.latitude;
    lon = position.longitude;
  }
  String api='https://api.openweathermap.org/data/2.5/forecast?lat=${lat.toString()}&lon=${lon.toString()}&appid=7b1056a7f41d0112c888f34e10ef592e&units=metric';
  if(city!=null)
    api="https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=7b1056a7f41d0112c888f34e10ef592e&units=metric";
  final responce=await http.get(Uri.parse(api));
  if(responce.statusCode==200)
  {
    data=jsonDecode(responce.body);
    String formatedDate;
    String previousDate="";
    for(int i=0;i<data['list'].length;i++)
    {
      formatedDate = DateFormat('EEEE').format(DateTime.parse(data['list'][i]['dt_txt']));
      if (previousDate != formatedDate)
      {
        dailyForecastList.add(data['list'][i]);
        previousDate = formatedDate;
        if(dailyForecastList.length==5)
          break;
      }
    }
    final m={"city":data["city"]["name"]};
    dailyForecastList.add(m);
    return dailyForecastList;
  }
  else
    throw Exception("Data is Not Fetched!");

}
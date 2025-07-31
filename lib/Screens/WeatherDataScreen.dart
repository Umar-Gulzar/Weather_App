import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:glass_container/glass_container.dart';
import 'dart:ui';

import '../Services/5DayForecast.dart';



class WeatherDataScreen extends StatefulWidget
{
  String? city;
  State<WeatherDataScreen> createState()=>WeatherDataScreenState(city: this.city);
  WeatherDataScreen({this.city});
}

class WeatherDataScreenState extends State<WeatherDataScreen>
{
  String? city;
  int _currentIndex=0;
  WeatherDataScreenState({this.city});
  List<Map<String,dynamic>> list=[];
  String getFormattedDate(DateTime dt)
  {
       return DateFormat('EEEE').format(dt);
  }
  Future<void> get5DayForecast()async
  {
    list=await getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Text("Weather",style: TextStyle(color:Colors.white,shadows: [Shadow(
          color: Colors.white,
          offset: Offset(0, 2),
          blurRadius: 7,
        )]),),
        centerTitle: true,
        foregroundColor: Colors.white,

      ),


      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Colors.blue.shade50,
            Colors.blue.shade50,Colors.blue.shade200,Colors.blue.shade100,Colors.blue.shade300
           ],begin: Alignment.topCenter,end: Alignment.bottomCenter,)
        ),
        child: FutureBuilder(future: get5DayForecast(), builder: (context,snap)
        {
          if(snap.hasError)
            return Text('${snap.error}');
          else if(snap.connectionState==ConnectionState.waiting)
            return Center(child: CircularProgressIndicator(),);
          else
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GlassContainer(
                        contHeight: 315,
                       contWidth: double.infinity,
                        shadowColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(list[5]['city'],style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold),),
                              Text(getFormattedDate(DateTime.parse(list[_currentIndex]['dt_txt']))),
                              SizedBox(height: 10,),
                              Text('${list[_currentIndex]["main"]['temp']} °C ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:30),),
                              SizedBox(height: 10,),
                              LayoutBuilder(
                                  builder: (context,constraints){
                                    return Row(
                                      children: [
                                        Image.network( "https://openweathermap.org/img/wn/${list[_currentIndex]['weather'][0]['icon']}@2x.png",height: constraints.maxWidth*0.3,width: constraints.maxWidth*0.3,),
                                        SizedBox(width: 10,),
                                        SizedBox(width: 50,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Humidity: ${list[_currentIndex]["main"]['humidity']}%',style: TextStyle(color: Colors.black,fontSize: constraints.maxWidth*0.05),),
                                            Text('Pressure: ${list[_currentIndex]["main"]['pressure']} hPa',style: TextStyle(color: Colors.black,fontSize: constraints.maxWidth*0.05),),
                                            Text('WindSpeed: ${list[_currentIndex]["wind"]['speed']} m/s',style: TextStyle(color: Colors.black,fontSize: constraints.maxWidth*0.05),),
                                            Text('Visibility: ${list[_currentIndex]['visibility']} m',style: TextStyle(color: Colors.black,fontSize: constraints.maxWidth*0.05),),
                                          ],)
                      
                                      ],
                                    );}
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 15,),
                  Padding(padding:EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("5 Day Forecast",
                            style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          IconButton(onPressed: (){
                            setState(() {

                            });
                          }, icon: Icon(Icons.arrow_forward,color: Colors.black,))
                        ],
                      )
                  ),

                  Container(
                    decoration: BoxDecoration(backgroundBlendMode: BlendMode.lighten,
                       color: Colors.transparent,
                       gradient: LinearGradient(colors:[Colors.black.withOpacity(0.8),Colors.lime.withOpacity(0.6)],begin: Alignment.topCenter,end: Alignment.bottomCenter)
                    ),
                    height: 300,
                    child: ListView.builder(
                        itemCount:list.length-1,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)
                    {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: (){setState(() {
                            _currentIndex=index;
                          });},
                          child: GlassContainer(
                            shadowColor: Colors.transparent,
                            child: Column(
                              children: [
                                SizedBox(height: 15,),
                                Text(getFormattedDate(DateTime.parse(list[index]['dt_txt'])),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Image.network( "https://openweathermap.org/img/wn/${list[index]['weather'][0]['icon']}@2x.png"),
                                Text('${list[index]['weather'][0]['description']}',style: TextStyle(fontSize: 17)),
                                SizedBox(height: 10,),
                                Text('${list[index]["main"]['temp_max']} °C '),
                                SizedBox(height: 5,),
                                Text('${list[index]["main"]['temp_min']} °C '),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    ),
                  )


                ],
              ),

            );
        }
        ),
      )


    );
  }
}

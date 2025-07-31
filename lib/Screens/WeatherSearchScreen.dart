import 'package:flutter/material.dart';
import '../Services/Location.dart';
import '../Animation/PageRouteAnimation.dart';
import 'WeatherDataScreen.dart';

class WeatherSearchScreen extends StatefulWidget
{
  State<WeatherSearchScreen> createState()=>WeatherSearchScreenState();
}
class WeatherSearchScreenState extends State<WeatherSearchScreen>
{

  TextEditingController _cityName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ Colors.blue.shade50,
                    Colors.blue.shade50,Colors.blue.shade200,Colors.blue.shade100,Colors.blue.shade300
                  ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Image.asset("Images/rain.png",height: 200,width: 200,),
                SizedBox(height: 25,),
                Text("Search Weather",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40),),
                SizedBox(height: 80,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherDataScreen(),),);
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child:Text("Current Location",style: TextStyle(color: Colors.white),)),
                SizedBox(height: 20,),
                Text('or'),
                SizedBox(height: 30,),
                Container(
                  width: 350,
                  child: TextField(
                    controller: _cityName,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText:("City"),
                      labelText:("City Name"),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      //labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,

                            )
                        )
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, PageRouteAnimation(WeatherDataScreen(city:_cityName.text)));
                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child:Text("Search",style: TextStyle(color: Colors.white),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
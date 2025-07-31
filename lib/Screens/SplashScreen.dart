import 'dart:async';
import '../Animation/PageRouteAnimation.dart';
import 'package:flutter/material.dart';
import 'WeatherSearchScreen.dart';

class  SplashScreen  extends StatefulWidget
{
  State<SplashScreen> createState()=>SplashScreenState();
}
class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin
{
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    _fadeAnimation=Tween<double>(begin: 0.3,end: 0.7).chain(CurveTween(curve:Curves.easeInOut)).animate(_controller);
    _scaleAnimation=Tween<double>(begin: 1,end: 1.05).chain(CurveTween(curve:Interval (0,1,curve:Curves.easeInOut))).animate(_controller);
    _controller.repeat(reverse: true);

   Timer(const Duration(seconds: 3),(){
     Navigator.push(context, PageRouteAnimation(WeatherSearchScreen()));
   });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     body: Container(
       height: double.infinity,
       width: double.infinity,
       decoration: BoxDecoration(
           gradient: LinearGradient(colors:[
             Colors.blue.shade50,
             Colors.blue.shade50,Colors.blue.shade200,Colors.blue.shade100,Colors.blue.shade300
           ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
       ),
       child: Align(alignment:Alignment.center,
           child: ScaleTransition(
             scale: _scaleAnimation,
             child: FadeTransition(
               opacity: _fadeAnimation,
               child: Image.asset(
                 fit:BoxFit.cover,"Images/rain.png",height: 200,width: 200,),
             ),
           )
       ),
     ),
   );
  }
}
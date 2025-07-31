import 'package:flutter/material.dart';


class  PageRouteAnimation extends PageRouteBuilder
{
  Widget child;
  PageRouteAnimation(this.child):super(
    pageBuilder: (context,animation,secondaryAnimation)=>child, //animation act as a controller for new coming screen.
    transitionDuration: Duration(milliseconds: 900),  //secondary animation act as a controller for old/previous/current screen which comes out.
    reverseTransitionDuration: Duration(milliseconds: 600), //when page will pop.
    transitionsBuilder: (context,animation,secondaryAnimation,child){
      //here child is new screen jis ko hum animated widgets sy wrap kar ky return kar wa ay gy.
      Animation<double> _fadeAnimation=Tween<double>(begin: 0.0,end: 1).chain(CurveTween(curve: Interval(0, 0.3,curve: Curves.easeIn))).animate(animation);
      Animation<double> _scaleAnimation=Tween<double>(begin:0.95,end: 1.0).chain(CurveTween(curve: Curves.easeInOutBack)).animate(animation);
      Animation<Offset> _slideAnimation=Tween<Offset>(begin:Offset(0.2, 0),end:Offset.zero).chain(CurveTween(curve: Curves.easeInOutBack)).animate(animation);

      return FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
              scale: _scaleAnimation,
              child: child
          ),
        ),
      );
    }

  );
}
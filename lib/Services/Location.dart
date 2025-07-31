import 'package:geolocator/geolocator.dart';

class Location
{
  Future<Position> getCurrentPosition()async
  {
    LocationPermission permission;
    if(await Geolocator.isLocationServiceEnabled()==false)
      return Future.error("Location services are disabled.");
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied)
      permission=await Geolocator.requestPermission();
    if(permission==LocationPermission.denied)
    {
      return Future.error("Location permissions are denied");
    }
    if(permission==LocationPermission.deniedForever)
    {
      return Future.error("Location permissions are permanently denied, we cannot request permissions.");
    }
   return await Geolocator.getCurrentPosition(
    );

  }
}
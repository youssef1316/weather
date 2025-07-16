import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    //checking if location is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled){
      throw Exception('Location is not enabled');
    }

    //requesting permission
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        throw Exception('Location request is not denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      throw Exception('Location is permanently denied');
    }

    //Get the current location
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest
    );
  }
}
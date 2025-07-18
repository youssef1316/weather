import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../service/location.dart';
import '../service/weather_service.dart';
import '../model/weather_data.dart';

class WeatherViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService= WeatherService();

  bool _isloading = false;
  String? _errormessage;
  Position? _currentposition;
  List <DailyData> _forecast = [];
  String? _cityName;

  bool get isLoading => _isloading;
  String? get errorMessage => _errormessage;
  Position? get currentPosition => _currentposition;
  List <DailyData> get forecast => _forecast;
  String? get cityName => _cityName;

  Future<void> fetchCurretLocation () async {
    _isloading = true;
    _errormessage = null;
    notifyListeners();
    try{
      _currentposition = await _locationService.getCurrentLocation();
    } catch (e) {
      _errormessage = e.toString();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWeather() async{
    _isloading = true;
    _errormessage = null;
    try{
      _currentposition ??= await _locationService.getCurrentLocation();
      final data = await _weatherService.fetchWeather(
          _currentposition!.latitude,
          _currentposition!.longitude);
      _forecast = data.forecastdays;
      _cityName = data.cityName;
    } catch (e){
      _errormessage = e.toString();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
  void clearerror() {
    _errormessage = null;
    notifyListeners();
}
}
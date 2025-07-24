import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../service/location.dart';
import '../service/weather_service.dart';
import '../model/weather_data.dart';
import '../../training/service/training_service.dart';

class WeatherViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService= WeatherService();
  final TrainingService _trainingService = TrainingService();

  bool _isloading = false;
  String? _errormessage;
  Position? _currentposition;
  List <DailyData> _forecast = [];
  String? _cityName;
  Map<DateTime, bool> _trainingPrediction = {};

  bool get isLoading => _isloading;
  String? get errorMessage => _errormessage;
  Position? get currentPosition => _currentposition;
  List <DailyData> get forecast => _forecast;
  String? get cityName => _cityName;
  Map<DateTime, bool> get TraininPredection => _trainingPrediction;

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

      await _predict();

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

  List<int> getFeatures(DateTime day){
    final data = _forecast.firstWhere(
        (d) => d.date.day == day.day,
      orElse: () => throw Exception('No forecast for selected day.')
    );
    // Rain, Sunny, Hot, Mild, humidity
    final condition = data.condition.toLowerCase();
    final maxTemp = data.maxTemp;
    final avgTemp = (data.maxTemp + data.minTemp) / 2;
    final humidity = data.humidity;

    final isRainy = condition.contains('rain') ? 1 : 0;
    final isSunny = condition.contains('sun') ? 1 : 0;
    final isHot = maxTemp > 30 ? 1 : 0;
    final isMild = avgTemp >= 18 && avgTemp <= 28 ? 1 : 0;
    final isHumid = humidity >= 40 && humidity <= 60 ? 1 : 0;

    return [isRainy, isSunny, isHot, isMild, isHumid];
  }

  Future<void> _predict() async {
    _trainingPrediction.clear();

    for (var day in _forecast) {
      try {
        final features = getFeatures(day.date);
        final result = await _trainingService.getTraining(features);
        _trainingPrediction[day.date] = result.isSuitable as bool;
      } catch (_) {
        _trainingPrediction[day.date] = false; // Fallback on error
      }
    }
  }
  bool? getTrainingSuitability(DateTime day) {
    return _trainingPrediction[day];
  }
}
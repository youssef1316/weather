import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../service/location.dart';

class WeatherViewModel extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  bool _isloading = false;
  String? _errormessage;
  Position? _currentposition;

  bool get isLoading => _isloading;
  String? get errorMessage => _errormessage;
  Position? get currentPosition => _currentposition;

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
  void clearerror() {
    _errormessage = null;
    notifyListeners();
}
}
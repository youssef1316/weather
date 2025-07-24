import 'package:flutter/material.dart';
import '../usecase/training_usecase.dart';
import '../../weather/model/weather_data.dart';
import 'package:flutter/foundation.dart';

class Training extends ChangeNotifier{
  final TrainingUsecase _trainingUsecase;
  Training(this._trainingUsecase);

  int ? _issuitable;
  String ? _errormessage ;
  bool _isloading = false;
  List<int>? _lastFeatures;

  int? get isSuitable => _issuitable;
  String? get errorMessage => _errormessage;
  bool get isLoading => _isloading;

  Future <void> FetchResponse(List<int> features) async{

    if(_isloading) return;
    if(_lastFeatures != null && listEquals(_lastFeatures, features)) return;
    print("Fetch started");
    _isloading = true;
    _errormessage = null;
    notifyListeners();
    try{
      print('selected features: ${features}');
      _lastFeatures = features;
      final result = await _trainingUsecase.execute(features);
      _issuitable = result.isSuitable;
      notifyListeners();
      print("response: ${result}");
    } catch (e) {
      _errormessage = 'Error: $e';
    }
    finally{
      _isloading = false;
      notifyListeners();
    }
  }

  void Clear (){
    _issuitable = null;
    _errormessage = null;
    _isloading = false;
    _lastFeatures = null;
    notifyListeners();
  }

}
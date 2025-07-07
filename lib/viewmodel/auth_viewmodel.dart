import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class AuthViewModel extends ChangeNotifier {
  final Authentication _authService = Authentication();

  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<User?> login(String email, String pass) async{
    try{
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final user = await _authService.signInWithEmailAndPassword(email, pass);
      return user;
    } catch (e){
      _errorMessage = e.toString().replaceAll("Exeption: ", "");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void clearError(){
    _errorMessage = null;
    notifyListeners();
  }
}
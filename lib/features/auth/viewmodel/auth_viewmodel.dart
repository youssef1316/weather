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

  Future<User?> signup(String email, String password) async{
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final user = await _authService.signUpWithEmailAndPassword(email, password);
      return user;
    } catch (e){
      _errorMessage = e.toString().replaceAll("Exeption: ", "");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 Future <bool> resetPassword (String email) async{
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      await _authService.sendPasswordResetEmail(email);
      return true;
    }
    catch(e) {
      _errorMessage = e.toString().replaceAll("Exeption: ", "");
      return false;
    }
    finally {
      _isLoading = false;
      notifyListeners();
    }
 }

}
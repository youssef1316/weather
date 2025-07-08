import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future <User?> signInWithEmailAndPassword(String email, String password) async{
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.message);
    }
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    try{
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );
      return credential.user;
    } on FirebaseAuthException catch(e){
      throw Exception(e.message);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async{
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e){
      throw Exception(e.message);
    }
  }

  Future <void> signOut() async{
    await _auth.signOut();
  }
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
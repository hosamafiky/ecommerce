import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult;
  }

  Future<AuthResult> logIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authResult;
  }
}

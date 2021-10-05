import 'package:red_egresados/data/repositories/auth.dart';

class AuthManagement {
  static final Auth _auth = Auth();

  static Future<bool>  signIn(
      {required String email, required String password}) async {
    try {
      return await _auth.signIn(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      return await _auth.signUp(name: name, email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}

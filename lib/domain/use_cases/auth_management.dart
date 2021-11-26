import 'package:red_egresados/data/repositories/password_auth.dart';

class AuthManagement {
  PasswordAuth auth = PasswordAuth();

  AuthManagement({
    required this.auth,
  });

  Future<bool> signIn({required String email, required String password}) async {
    try {
      return await auth.signIn(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      return await auth.signUp(name: name, email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}

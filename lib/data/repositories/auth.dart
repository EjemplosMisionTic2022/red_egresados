import 'package:red_egresados/domain/repositorires/auth.dart';

class Auth implements AuthInterface {
  @override
  Future<bool> signIn({required String email, required String password}) async {
    final emailVal = "barry.allen@example.com" == email;
    final passwordVal = "SuperSecretPassword!" == password;
    return emailVal && passwordVal;
  }

  @override
  Future<bool> signOut() async {
    return true;
  }

  @override
  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final emailVal = email.contains("@") && email.contains(".co");
    final passwordVal = password.length > 6;
    return emailVal && passwordVal;
  }
}

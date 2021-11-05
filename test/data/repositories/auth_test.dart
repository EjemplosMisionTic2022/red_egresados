import 'package:flutter_test/flutter_test.dart';

void main() {
  late Auth auth;

  setUp(() {
    auth = Auth();
  });

  test('auth-signin', () async {
    final result = await auth.signIn(
        email: "barry.allen@example.com", password: "SuperSecretPassword!");
    expect(result, true);
  });

  test('auth-signup', () async {
    final result = await auth.signUp(
        name: "Barry Allen",
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!");
    expect(result, true);
  });

  test('auth-signout', () async {
    final result = await auth.signOut();
    expect(result, true);
  });
}

class Auth {
  signIn({required String email, required String password}) {}

  signUp(
      {required String name,
      required String email,
      required String password}) {}

  signOut() {}
}

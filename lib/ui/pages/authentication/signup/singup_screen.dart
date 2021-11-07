import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/domain/use_cases/auth_management.dart';
import 'package:red_egresados/domain/use_cases/controllers/authentication.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const SignUpScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Creación de usuario",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signUpName"),
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuario',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signUpEmail"),
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signUpPassword"),
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Clave',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      var result = await AuthManagement.signUp(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text);
                      controller.authenticated = result;
                    },
                    child: const Text("Registrar"),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: widget.onViewSwitch,
            child: const Text("Entrar"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

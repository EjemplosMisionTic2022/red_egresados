import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:red_egresados/ui/pages/authentication/auth_page.dart';
import 'package:red_egresados/ui/pages/content/content_page.dart';
import 'package:red_egresados/ui/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // Este widget es la raíz de su aplicación.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Red Egresados MinTIC',
      // Quitamos el banner DEBUG
      debugShowCheckedModeBanner: false,
      // Establecemos el tema claro
      theme: MyTheme.ligthTheme,
      // Establecemos el tema oscuro
      darkTheme: MyTheme.darkTheme,
      // Por defecto tomara la seleccion del sistema
      themeMode: ThemeMode.system,
      home: const AuthenticationPage(),
       // ---------------------------------------
       // 1. Crea las rutas posibles para nuestra app
       // ---------------------------------------
      routes: {},
    );
  }
}
